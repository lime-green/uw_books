require File.join(File.dirname(__FILE__), '../crawler/crawler')

namespace :crawler do
  desc "crawls the blooklook website and write book information to database"
  task :crawl, [:term] => [:environment] do |t, args|
    books = Crawler.new(args.term).get_books
    books.each do |book|
      ActiveRecord::Base.transaction do
        MultiRepository.new_record(BookHashTranslator.translate book)
      end
    end
  end

end # end namespace
