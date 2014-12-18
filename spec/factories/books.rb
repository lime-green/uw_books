require 'faker'

FactoryGirl.define do
  factory :book do
    author { Faker::Name.name }
    title  { Faker::Lorem.sentence }

    sku { ((1..9).to_a.sample.to_s + Faker::Number.number(12).to_s).to_i }
    price { Faker::Commerce.price }
    stock { Faker::Number.digit }

    reqopt { [true, false].sample }

    trait :with_single_course do
      courses { [FactoryGirl.create(:course)] }
    end
  end

  factory :course do
    instructor { Faker::Name.name }
    department { ["CS", "MATH", "BIO", "CHEM", "ECON"].sample }
    term { ((1..9).to_a.sample.to_s + Faker::Number.number(3).to_s).to_i }
    section { "%03d" % Faker::Number.digit }
    number { ((1..9).to_a.sample.to_s + Faker::Number.number(2).to_s).to_i }
  end
end
