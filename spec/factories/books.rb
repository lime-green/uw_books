require 'faker'

FactoryGirl.define do
  factory :book do |f|
    f.author { Faker::Name.name }
    f.title  { Faker::Lorem.sentence }
    f.instructor { Faker::Name.name }
    f.department { Faker::Lorem.characters(5) }

    f.sku { Faker::Number.number(13) }
    f.term { Faker::Number.number(4) }
    f.price { Faker::Commerce.price }
    f.stock { Faker::Number.digit }
    f.section { Faker::Number.digit }
    f.course { Faker::Number.number(3) }

    f.reqopt [true, false].sample
  end
end

  #validates :author,     presence: true, allow_blank: false, length: { maximum: 255 }
  #validates :title,      presence: true, allow_blank: false, length: { maximum: 255 }
  #validates :instructor, presence: true, allow_blank: false, length: { maximum: 255 }
  #validates :department, presence: true, allow_bank: false, length: { in: 2..10 }

  ## numeric validations
  #validates :sku, presence:  true, length: { is: 13 }
  #validates :term, presence: true, length: { is: 4 }
  #validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  #validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  #validates :section, presence: true, allow_blank: false
  #validates :course,  presence: true, allow_bank: false, length: { in: 3..4 }

  ## boolean validations
  #validates :reqopt, presence: true
