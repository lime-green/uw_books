require File.join(File.dirname(__FILE__), '../crawler/crawler')

namespace :crawler do
  desc "crawls the blooklook website and write book information to database"
  task crawl: :environment do
    Crawler.new.get_books
  end

end # end namespace
