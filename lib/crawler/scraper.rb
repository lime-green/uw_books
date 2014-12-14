module Scraper
  def self.scrape_page(document)
    book_nodes = document.search("div.book_info")
    book_nodes.map do |book_node|
      {
        author: book_node.css(".author"),
        title: book_node.css(".title"),
        sku: book_node.css(".sku"),
        price: book_node.css(".price"),
        stock: book_node.css(".stock"),
        term: book_node.xpath("//input[@name='mv_order_orderline_term']"),
        department: book_node.xpath("//input[@name='mv_order_orderline_department']"),
        course: book_node.xpath("//input[@name='mv_order_orderline_course']"),
        section: book_node.xpath("//input[@name='mv_order_orderline_section']"),
        instructor: book_node.xpath("//input[@name='mv_order_orderline_instructor']"),
        reqopt: book_node.xpath("//input[@name='mv_order_orderline_reqopt']"),
        quantity: book_node.xpath("//input[@name='mv_order_quantity']")
      }
    end
  end
end
