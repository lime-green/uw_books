require_relative 'scraper'
require 'digest'
class Crawler
  require 'mechanize'
  require 'net/http'
  ROOT_URL = "https://fortuna.uwaterloo.ca/cgi-bin/cgiwrap/rsic/book"
  CURRENT_TERM = "1149" # calculate this?

  VERBOSE = false # useful messages

  SLICE_MAX = 5         # crawl this amount of links asynchronously
  RETRY_DELAY = 10      # sleep for this amount of seconds after a failed request

  def initialize

    @output = []

    # Prepare page
    @agent = Mechanize.new
    @root_page = @agent.get(ROOT_URL)
    target_form = @root_page.at('div#search_box_course form') # Nokogiri object
    target_form = Mechanize::Form.new( target_form )          # Convert back to Mechanize object
    target_form.field_with(value: /[0-9]{4}/).option_with(value: CURRENT_TERM).click # Select the term
    @root_page = @agent.submit(target_form) # first page of results
  end

  def get_page(link, thread_name)
    attempt = 1
    attempt_max = 5
    while attempt <= attempt_max do
      begin
        page = @agent.get(link.href)
        break
      rescue Mechanize::ResponseCodeError => exception
        if exception.response_code == '500'
          print_verbose "HTTPInternalServerError in #{thread_name}: will try again in #{RETRY_DELAY} seconds (attempt #{attempt})"
          attempt += 1
          sleep RETRY_DELAY
        else
          raise
        end
      end
    end
    raise "Over #{attempt_max} attempts made for #{link.href}, exiting" if attempt > attempt_max
    return page
  end

  def crawl!
    # Retrieve all links to paginated results. As at Dec 10/2014 there are 301 pages for term 1149
    links = @root_page.links_with(href: /book\/scan/).uniq { |link| link.href }

    threads = []
    num_threads = 1

    books = Queue.new

    threads << Thread.new do
      add_books(books, @root_page)
    end

    # for now, scrape only 10 links (2 slices of 5)
    links.take(10).each_slice(SLICE_MAX) do |slice|
      slice.each do |link|
        threads << Thread.new do
          num_threads += 1;
          document = get_page(link, "Thread ##{num_threads}")
          add_books(books, document)
        end
      end
      print_verbose "Scraping #{slice.size} links asynchronously"
      threads.each { |thr| thr.join }
      print_verbose "Done scraping that set"
    end

    # save all this data
    write_DB!(books)
  end # end crawl! function

  def get_characterization
    @output.sort! do |x,y|
      sku_comparison = x[:sku] <=> y[:sku]
      if sku_comparison == 0
        instructor_comparison = x[:instructor] <=> y[:instructor]
        if instructor_comparison == 0
          course_comparison = x[:course] <=> y[:course]
          if course_comparison == 0
            x[:section] <=> y[:section]
          else
            course_comparison
          end
        else
          instructor_comparison
        end
      else
        sku_comparison
      end
    end

    Digest::SHA256.hexdigest @output.to_s
  end

  # ALL PRIVATE FUNCTIONS FOLLOW
  private
  def print_verbose(string)
    print "====Crawler(verbose)====\n#{string}\n====END verbose====\n\n" if VERBOSE
  end

  def add_books(books, document)
    Scraper.scrape_page(document).each do |book|
      books << book
    end
  end

  def write_DB!(records)
    print_verbose "Writing to database"
    while records.length > 0 do
      # Book.create(row) or Book.update_attributes(row) if it exists
      @output << records.pop
    end
  end # end write_DB function
end # end class
