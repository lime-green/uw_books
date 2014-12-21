require 'crawler/scraper'
require 'nokogiri'
describe Scraper do

  it "scrapes an HTML document for books #1" do
    document = Nokogiri::HTML(File.open(File.dirname(__FILE__) + "/fixtures/fixture.html"))

    result = Scraper.scrape_page(document)

    expect(result.length).to eq(10)
    expect(result).to include(hash_including({
      author: "SHREVE S E",
      title: "STOCHASTIC CALCULUS FOR FINANCE 1",
      sku: "9780387249681",
      price: 62.00,
      stock: 5,
      term: "1149",
      department: "ACC",
      course: "770",
      section: "001",
      instructor: "Li,Bin",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "SHREVE",
      title: "STOCHASTIC CALCULUS FOR FINANCE II",
      sku: "9780387401010",
      price: 85.50,
      stock: 2,
      term: "1149",
      department: "ACC",
      course: "770",
      section: "001",
      instructor: "Li,Bin",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "LIPSON",
      title: "DOING HONEST WORK IN COLLEGE 2ND ED",
      sku: "9780226484778",
      price: 16.10,
      stock: 0,
      term: "1149",
      department: "ACC",
      course: "781",
      section: "001",
      instructor: "O'Brien,Patricia",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "SHADISH ET AL",
      title: "EXPERIMENTAL & QUASI-EXPERIMENTAL DESIGNS 2ED",
      sku: "9780395615560",
      price: 177.95,
      stock: 0,
      term: "1149",
      department: "ACC",
      course: "781",
      section: "001",
      instructor: "O'Brien,Patricia",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "TROCHIM & DONNELLY",
      title: "RESEARCH METHODS KNOWLEDGE BASE 3ED",
      sku: "9781592602919",
      price: 162.95,
      stock: 0,
      term: "1149",
      department: "ACC",
      course: "781",
      section: "001",
      instructor: "O'Brien,Patricia",
      reqopt: "O"
    }));

    expect(result).to include(hash_including({
      author: "BROWN ET AL",
      title: "MATHEMATICS OF FINANCE 7ED",
      sku: "9780070000186",
      price: 127.95,
      stock: 1,
      term: "1149",
      department: "ACTSC",
      course: "221",
      section: "001",
      instructor: "Blake,William Peter",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "BROWN & KOPP",
      title: "FINANCIAL MATHEMATICS: THEORY & PRACTICE",
      sku: "9781259033803",
      price: 87.95,
      stock: 121,
      term: "1149",
      department: "ACTSC",
      course: "231",
      section: "001",
      instructor: "Freeland,R Keith",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "DICKSON ET AL",
      title: "ACTUARIAL MATHEMATICS FOR LIFE CONTINGENT RISKS 2ND",
      sku: "9781107044074",
      price: 92.95,
      stock: 38,
      term: "1149",
      department: "ACTSC",
      course: "232",
      section: "001",
      instructor: "Adcock,James",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "DICKSON ET AL",
      title: "SOLUTIONS MANUAL FOR 2ED OF ACTUARIAL MATHEMATICS FOR LIFE CONTINGENT RISKS 2ED",
      sku: "9781107620261",
      price: 34.95,
      stock: 41,
      term: "1149",
      department: "ACTSC",
      course: "232",
      section: "001",
      instructor: "Adcock,James",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "DICKSON ET AL",
      title: "ACTUARIAL MATHEMATICS FOR LIFE CONTINGENT RISKS 2ND",
      sku: "9781107044074",
      price: 92.95,
      stock: 38,
      term: "1149",
      department: "ACTSC",
      course: "331",
      section: "001",
      instructor: "Hardy,Mary R",
      reqopt: "R"
    }));

  end

  it "scrapes an HTML document for books #2" do
    document = Nokogiri::HTML(File.open(File.dirname(__FILE__) + "/fixtures/fixture_2.html"))

    result = Scraper.scrape_page(document)

    expect(result.length).to eq(4)
    expect(result).to include(hash_including({
      author: "I-CLICKER",
      title: "I-CLICKER + RF RESPONSE REMOTE",
      sku: "9781464185922",
      price: 40.00,
      stock: 1081,
      term: "1151",
      department: "CS",
      course: "135",
      section: "001",
      instructor: "Vasiga,Troy Michael",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "FELLEISEN ET AL",
      title: "HOW TO DESIGN PROGRAMS",
      sku: "9780262062183",
      price: 97.00,
      stock: 50,
      term: "1151",
      department: "CS",
      course: "135",
      section: "001",
      instructor: "Vasiga,Troy Michael",
      reqopt: "O"
    }));

    expect(result).to include(hash_including({
      author: "I-CLICKER",
      title: "I-CLICKER + RF RESPONSE REMOTE",
      sku: "9781464185922",
      price: 40.00,
      stock: 1081,
      term: "1151",
      department: "CS",
      course: "135",
      section: "002",
      instructor: "Vasiga,Troy Michael",
      reqopt: "R"
    }));

    expect(result).to include(hash_including({
      author: "FELLEISEN ET AL",
      title: "HOW TO DESIGN PROGRAMS",
      sku: "9780262062183",
      price: 97.00,
      stock: 50,
      term: "1151",
      department: "CS",
      course: "135",
      section: "002",
      instructor: "Vasiga,Troy Michael",
      reqopt: "O"
    }));

  end
end
