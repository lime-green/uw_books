namespace :crawler do
  desc "crawls the blooklook website and write book information to database"
  task crawl: :environment do
    Crawler.new.crawl!
  end

  class Crawler
    require 'mechanize'
    require 'net/http'
    attr_reader :queue
    ROOT_URL = "https://fortuna.uwaterloo.ca/cgi-bin/cgiwrap/rsic/book"

    def initialize
      @current_term = "1149" # calculate this?
      @verbose = true        # useful messages
      @slice_max = 5         # crawl this amount of links asynchronously
      @retry_delay = 10      # sleep for this amount of seconds after a failed request

      # Prepare page
      @agent = Mechanize.new
      @root_page = @agent.get(ROOT_URL)
      target_form = @root_page.at('div#search_box_course form') # Nokogiri object
      target_form = Mechanize::Form.new( target_form )          # Convert back to Mechanize object
      target_form.field_with(value: /[0-9]{4}/).option_with(value: @current_term).click # Select the term
      @root_page = @agent.submit(target_form) # first page of results

      @queue = Array.new # array of hashes used to build records
    end

    def scrape_page!(page)
      # All the book information are in separate book_info divs
      book_nodes = page.search("div.book_info")
      book_nodes.each do |book_node|
        book_record = Hash.new
        # get book data (format is: <p><span class="author">Orson Scott-Card</span></p>)
        book_node.search("p span").each do |book_info|
          key = "unknown_key" unless key = book_info.attr("class")
          val = "unknown_val" unless val = book_info.inner_text.delete("\n").gsub(/\s+/," ")
          book_record[key.to_sym] = val
        end

        # get ISBN number (found in an external link to a library resource. ISBN is 13 digits)
        # useful to provide in API, as well as maybe listing the cheapest prices using isbnsearch.org
        # NOTE: ISBN appears to always be the same as booklook's SKU (stock keeping unit) which is provided above
        link_node =  book_node.search("p a").select { |node| node['href'] =~ /=[0-9]{13}/ }
        isbn = link_node.map { |link| link['href'] =~ /([0-9]{13})/; $1 }.first
        book_record[:isbn] = isbn

        # get course info(teacher, section, etc) associated with this book (all hidden fields)
        book_node.search("input[type=hidden]").each do |hidden|
          key = "unknown_key" unless key = hidden.attr("name")
          val = "unknown_val" unless val = hidden.attr("value").delete("\n").gsub(/\s+/," ")
          book_record[key.to_sym] = val
        end
        @queue << book_record
      end
    end

    def start_scrape!(link, thread_name)
      attempt = 1
      attempt_max = 5
      while attempt <= attempt_max do
        begin
          page = @agent.get(link.href)
          scrape_page! page
          break
        rescue Mechanize::ResponseCodeError => exception
          if exception.response_code == '500'
            print_verbose "HTTPInternalServerError in #{thread_name}: will try again in #{@retry_delay} seconds (attempt #{attempt})"
            attempt += 1
            sleep @retry_delay
          else
            raise
          end
        end
      end
      raise "Over #{attempt_max} attempts made for #{link.href}, exiting" if attempt > attempt_max
    end

    def crawl!
      # Retrieve all links to paginated results. As at Dec 10/2014 there are 301 pages for term 1149
      links = @root_page.links_with(href: /book\/scan/).uniq { |link| link.href }

      threads = []
      num_threads = 0
      threads << Thread.new { scrape_page! @root_page; num_threads += 1 } # first page has already been retrieved so can call scrape_page! directly

      # for now, scrape only 10 links (2 slices of 5)
      links.take(10).each_slice(@slice_max) do |slice|
        slice.each do |link|
          threads << Thread.new { num_threads += 1; start_scrape! link, "Thread ##{num_threads}" }
        end
        print_verbose "Scraping #{slice.size} links asynchronously"
        threads.each { |thr| thr.join }
        print_verbose "Done scraping that set"
      end
      # save all this data
      write_DB!
    end # end crawl! function

    # ALL PRIVATE FUNCTIONS FOLLOW
    private
    def print_verbose(string)
      print "====Crawler(verbose)====\n#{string}\n====END verbose====\n\n" if @verbose
    end

    def write_DB!
      print_verbose "Writing to database"
      ActiveRecord::Base.transaction do
        @queue.each do |row|
          # Book.create(row) or Book.update_attributes(row) if it exists
          pp row
        end
      end
    end # end write_DB function
  end # end class
end # end namespace
