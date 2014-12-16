class Book < ActiveRecord::Base
  # string validations
  validates :author,     presence: true, allow_blank: false, length: { maximum: 255 }
  validates :title,      presence: true, allow_blank: false, length: { maximum: 255 }
  validates :instructor, presence: true, allow_blank: false, length: { maximum: 255 }
  validates :section,    presence: true, allow_blank: false, length: { is: 3 }
  validates :department, presence: true, allow_bank:  false, length: { in: 2..10 }

  # numeric validations
  validates :sku, presence:  true, length: { is: 13 }
  validates :term, presence: true, length: { is: 4 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :course,  presence: true, allow_bank: false, length: { in: 3..4 }

  # boolean validations
  validates :reqopt, inclusion: [true, false]
end
