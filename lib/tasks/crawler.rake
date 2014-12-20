require File.join(File.dirname(__FILE__), '../crawler/crawler')

namespace :crawler do
  desc "crawls the blooklook website and write book information to database"
  task crawl: :environment do
    pp Rails.env
    Crawler.new.crawl!
  end

end # end namespace
