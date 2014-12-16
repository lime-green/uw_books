require 'faker'

FactoryGirl.define do
  factory :book do |f|
    f.author { Faker::Name.name }
    f.title  { Faker::Lorem.sentence }
    f.instructor { Faker::Name.name }
    f.department { Faker::Lorem.characters(5) }

    f.sku { ((1..9).to_a.sample.to_s + Faker::Number.number(12).to_s).to_i }
    f.term { ((1..9).to_a.sample.to_s + Faker::Number.number(3).to_s).to_i }
    f.price { Faker::Commerce.price }
    f.stock { Faker::Number.digit }
    f.section { "%03d" % Faker::Number.digit }
    f.course { ((1..9).to_a.sample.to_s + Faker::Number.number(2).to_s).to_i }

    f.reqopt [true, false].sample
  end
end
