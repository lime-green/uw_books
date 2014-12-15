module Scraper
  def self.scrape_page(document)
    book_nodes = document.search("div.book_info")
    book_nodes.map do |book_node|
      {
        author: book_node.css(".author").text,
        title: book_node.css(".title").text,
        sku: book_node.css(".sku").text,
        price: book_node.css(".price").text,
        stock: book_node.css(".stock").text.gsub(/[\n\t]/, ""),
        term: book_node.at_xpath("input[@name='mv_order_orderline_term']")[:value],
        department: book_node.at_xpath("input[@name='mv_order_orderline_department']")[:value],
        course: book_node.at_xpath("input[@name='mv_order_orderline_course']")[:value],
        section: book_node.at_xpath("input[@name='mv_order_orderline_section']")[:value],
        instructor: book_node.at_xpath("input[@name='mv_order_orderline_instructor']")[:value],
        reqopt: book_node.at_xpath("input[@name='mv_order_orderline_reqopt']")[:value],
      }
    end
  end
end
