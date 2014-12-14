require 'crawler/scraper'
describe Scraper do

  it "scrapes an HTML document for books" do
    document = double("BookLook Document")

    book_node = double("Book 1")

    allow(book_node).to receive(:css).with(".author").and_return("William Gibson")
    allow(book_node).to receive(:css).with(".title").and_return("Neuromancer")
    allow(book_node).to receive(:css).with(".sku").and_return("12345")
    allow(book_node).to receive(:css).with(".price").and_return("$13.37")
    allow(book_node).to receive(:css).with(".stock").and_return("42")
    allow(book_node).to receive(:xpath).with("//input[@name='mv_order_orderline_term']").and_return("1151")
    allow(book_node).to receive(:xpath).with("//input[@name='mv_order_orderline_department']").and_return("CS")
    allow(book_node).to receive(:xpath).with("//input[@name='mv_order_orderline_course']").and_return("666")
    allow(book_node).to receive(:xpath).with("//input[@name='mv_order_orderline_section']").and_return("001")
    allow(book_node).to receive(:xpath).with("//input[@name='mv_order_orderline_instructor']").and_return("Ryan De Villa")
    allow(book_node).to receive(:xpath).with("//input[@name='mv_order_orderline_reqopt']").and_return("R")
    allow(book_node).to receive(:xpath).with("//input[@name='mv_order_quantity']").and_return("23")

    allow(document).to receive(:search).with("div.book_info").and_return([book_node])

    expect(Scraper.scrape_page(document)).to eq([{
      author: "William Gibson",
      title: "Neuromancer",
      sku: "12345",
      price: "$13.37",
      stock: "42",
      term: "1151",
      department: "CS",
      course: "666",
      section: "001",
      instructor: "Ryan De Villa",
      reqopt: "R",
      quantity: "23"
    }])
  end


end
