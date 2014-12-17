require 'faker'

FactoryGirl.define do
  factory :book do |f|
    f.author { Faker::Name.name }
    f.title  { Faker::Lorem.sentence }

    f.sku { ((1..9).to_a.sample.to_s + Faker::Number.number(12).to_s).to_i }
    f.price { Faker::Commerce.price }
    f.stock { Faker::Number.digit }

    f.reqopt [true, false].sample

    trait :with_courses do
      f.courses { [FactoryGirl.create(:course)] }
    end
  end

  factory :course do |f|
    f.instructor { Faker::Name.name }
    f.department { Faker::Lorem.characters(5) }
    f.term { ((1..9).to_a.sample.to_s + Faker::Number.number(3).to_s).to_i }
    f.section { "%03d" % Faker::Number.digit }
    f.number { ((1..9).to_a.sample.to_s + Faker::Number.number(2).to_s).to_i }

  end
end
