require_relative '../../../lib/crawler/crawler'

describe Crawler do
  let (:expected_digest) { "dfe0e42e1e2840e835d2124e307b83eb7b773ec55fe483c37bc1df532c143cc8" }
  it "crawls the BookLook site and creates records for all books found" do
    crawler = Crawler.new
    crawler.crawl!
    expect(crawler.get_characterization).to eq(expected_digest)
  end
end
