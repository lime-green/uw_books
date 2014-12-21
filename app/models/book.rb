class Book < ActiveRecord::Base
  has_and_belongs_to_many :courses
  # string validations
  validates :author,     presence: true, allow_blank: false, length: { maximum: 255 }
  validates :title,      presence: true, allow_blank: false, length: { maximum: 255 }

  # numeric validations
  validates :sku, presence:  true, length: { is: 13 }, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true

  # boolean validations
  validates :reqopt, inclusion: [true, false]
end
