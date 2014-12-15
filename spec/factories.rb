FactoryGirl.define do
  factory :book do
    author "William Gibson"
    title "Neuromancer"
    sku 1234567890123
    price 12.34
    stock 42
    term 1151
    department "CS"
    course "666"
    section 1
    instructor "Neal Stephenson"
    reqopt true
  end
end
