require 'rubygems'
require 'mechanize'

# options are
# :link
# :page
def scrape_page(agent, options={})
  # :page option will only be used for the first page
  # all the other results are paginated and can be provided through :link
  if !options[:link].nil?
    page = agent.get(options[:link])
  else
    page = options[:page]
  end

  # All the book information is in separate book_info divs
  book_nodes = page.search("div.book_info")
  book_nodes.each do |book_node|

    # get book data (format is: <p><span class="author">Orson Scott-Card</span></p>)
    book_node.search("p span").each do |book_info|
      key = "unknown_key" unless key = book_info.attr("class")
      val = "unknown_val" unless val = book_info.inner_text.delete("\n").gsub(/\s+/," ")
      puts "#{key} #{val}"
    end

    # get ISBN number (found in an external link to a library resource. ISBN is 13 digits)
    # useful to provide in API, as well as maybe listing the cheapest prices using isbnsearch.org
    # NOTE: ISBN appears to always be the same as booklook's SKU (stock keeping unit) which is provided above
    link_node =  book_node.search("p a").select { |node| node['href'] =~ /=[0-9]{13}/ }
    puts link_node.map { |link| link['href'] =~ /([0-9]{13})/; "isbn " + $1 }

    # get course data (all hidden fields)
    book_node.search("input[type=hidden]").each do |hidden|
      key = "unknown_key" unless key = hidden.attr("name")
      val = "unknown_val" unless val = hidden.attr("value").delete("\n").gsub(/\s+/," ")
      puts "#{key} #{val}"
    end

    # temporary separator
    puts "========="
  end
end

agent = Mechanize.new
page = agent.get('https://fortuna.uwaterloo.ca/cgi-bin/cgiwrap/rsic/book')
target_form = page.at('div#search_box_course form') # Nokogiri object
target_form = Mechanize::Form.new( target_form )    # Convert back to Mechanize object


target_form.field_with(value: /[0-9]{4}/).option_with(value: "1149").click # Maybe scrape current term and last term?
page = agent.submit(target_form)

## Retrieve all links to paginated results. As of Dec 12/2014 there are 201 pages
links = page.links_with(href: /book\/scan/).uniq { |link| link.href }
#pp links

scrape_page agent, page: page

#links.each do |link|
  #scrape_page agent, link: link.href
#end
