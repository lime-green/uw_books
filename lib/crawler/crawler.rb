require_relative 'scraper'
class Crawler
  require 'mechanize'
  require 'net/http'
  ROOT_URL = "https://fortuna.uwaterloo.ca/cgi-bin/cgiwrap/rsic/book"
  CURRENT_TERM = "1149" # calculate this?

  VERBOSE = true        # useful messages

  SLICE_MAX = 5         # crawl this amount of links asynchronously
  RETRY_DELAY = 10      # sleep for this amount of seconds after a failed request

  def initialize

    # Prepare page
    @agent = Mechanize.new
    @root_page = @agent.get(ROOT_URL)
    target_form = @root_page.at('div#search_box_course form') # Nokogiri object
    target_form = Mechanize::Form.new( target_form )          # Convert back to Mechanize object
    target_form.field_with(value: /[0-9]{4}/).option_with(value: CURRENT_TERM).click # Select the term
    @root_page = @agent.submit(target_form) # first page of results
  end

  def start_scrape!(link, thread_name)
    attempt = 1
    attempt_max = 5
    while attempt <= attempt_max do
      begin
        page = @agent.get(link.href)
        result = Scraper.scrape_page page
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
    return result
  end

  def crawl!
    # Retrieve all links to paginated results. As at Dec 10/2014 there are 301 pages for term 1149
    links = @root_page.links_with(href: /book\/scan/).uniq { |link| link.href }

    threads = []
    num_threads = 0

    books = Queue.new

    threads << Thread.new do

      Scraper.scrape_page(@root_page).each do |book|
        books << book
      end

      num_threads += 1
    end

    # for now, scrape only 10 links (2 slices of 5)
    links.take(10).each_slice(SLICE_MAX) do |slice|
      slice.each do |link|
        threads << Thread.new do
          num_threads += 1;

          start_scrape!(link, "Thread ##{num_threads}").each do |book|
            books << book
          end

        end
      end
      print_verbose "Scraping #{slice.size} links asynchronously"
      threads.each { |thr| thr.join }
      print_verbose "Done scraping that set"
    end
    # save all this data
    write_DB!(books)
  end # end crawl! function

  # ALL PRIVATE FUNCTIONS FOLLOW
  private
  def print_verbose(string)
    print "====Crawler(verbose)====\n#{string}\n====END verbose====\n\n" if VERBOSE
  end

  def write_DB!(records)
    print_verbose "Writing to database"
    ActiveRecord::Base.transaction do
      while records.length > 0 do
        # Book.create(row) or Book.update_attributes(row) if it exists
        pp records.pop
      end
    end
  end # end write_DB function
end # end class
