require_relative 'scraper'
require 'digest'
require 'mechanize'
require 'net/http'

class Crawler
  ROOT_URL = "https://fortuna.uwaterloo.ca/cgi-bin/cgiwrap/rsic/book"
  CURRENT_TERM = "1149" # calculate this?

  PAGE_CONNECTION_ATTEMPT_MAX = 5

  VERBOSE = true # useful messages

  SLICE_MAX = 5         # crawl this amount of links asynchronously
  RETRY_DELAY = 10      # sleep for this amount of seconds after a failed request

  def initialize
    @agent = Mechanize.new
  end

  def get_books
    crawl
  end

  private

  def get_page(link, thread_name)
    attempt = 1
    while attempt <= PAGE_CONNECTION_ATTEMPT_MAX do
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
    raise "Over #{PAGE_CONNECTION_ATTEMPT_MAX} attempts made for #{link.href}, exiting" if attempt > PAGE_CONNECTION_ATTEMPT_MAX
    return page
  end

  def crawl
    root_page = @agent.get(ROOT_URL)
    first_page = submit_form(root_page)

    # Retrieve all links to paginated results. As at Dec 10/2014 there are 301 pages for term 1149
    links = first_page.links_with(href: /book\/scan/).uniq { |link| link.href }

    threads = []
    num_threads = 1

    books = Queue.new

    threads << Thread.new do
      add_books(books, first_page)
    end

    # for now, scrape only 10 links (2 slices of 5)
    links.each_slice(SLICE_MAX) do |slice|
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

    result = []

    while books.length > 0 do
      result << books.pop
    end

    result
  end

  def submit_form(root_page)
    target_form = root_page.at('div#search_box_course form') # Nokogiri object
    target_form = Mechanize::Form.new( target_form )          # Convert back to Mechanize object
    target_form.field_with(value: /[0-9]{4}/).option_with(value: CURRENT_TERM).click # Select the term
    @agent.submit(target_form) # first page of results
  end

  def add_books(books, document)
    Scraper.scrape_page(document).each do |book|
      books << book
    end
  end

  def print_verbose(string)
    print "====Crawler(verbose)====\n#{string}\n====END verbose====\n\n" if VERBOSE
  end
end
