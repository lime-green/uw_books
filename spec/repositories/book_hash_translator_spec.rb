require 'spec_helper'
require 'rails_helper'

describe BookHashTranslator do
  let (:crawler_hash) {{
      author: "BROWN & KOPP",
      title: "FINANCIAL MATHEMATICS: THEORY & PRACTICE",
      sku: "9781259033803",
      price: "87.95",
      stock: "121",
      term: "1149",
      department: "ACTSC",
      course: "231",
      section: "001",
      instructor: "Freeland,R Keith",
      reqopt: "R"
  }}

  it "maps a hash from the Crawler into a hash consumable by a repo" do
    output = BookHashTranslator.translate(crawler_hash)
    expected_output = {
      author: "BROWN & KOPP",
      title: "FINANCIAL MATHEMATICS: THEORY & PRACTICE",
      sku: "9781259033803",
      price: "87.95",
      stock: "121",
      term: "1149",
      department: "ACTSC",
      number: "231",
      section: "001",
      instructor: "Freeland,R Keith",
      reqopt: "R"
    }
    expect(output).to eq(expected_output)
  end
end
