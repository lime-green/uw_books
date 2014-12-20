require_relative '../../../lib/crawler/crawler'
require 'digest'

describe Crawler do
  let (:expected_digest) { "dfe0e42e1e2840e835d2124e307b83eb7b773ec55fe483c37bc1df532c143cc8" }

  it "crawls the BookLook site and creates records for all books found" do
    crawler = Crawler.new
    expect(get_characterization(crawler.get_books)).to eq(expected_digest)
  end

  private

  def get_characterization(output)
    output.sort! do |x,y|
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

    Digest::SHA256.hexdigest output.to_s
  end
end
