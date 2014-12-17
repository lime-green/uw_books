class Course < ActiveRecord::Base
  before_save :upcase_indices
  has_and_belongs_to_many :books

  validates :instructor, presence: true, allow_blank: false, length: { maximum: 255 }
  validates :section,    presence: true, allow_blank: false, length: { is: 3 }
  validates :department, presence: true, allow_bank:  false, length: { in: 2..10 }
  validates :number,  presence: true, allow_bank: false, length: { in: 3..4 }
  validates :term, presence: true, length: { is: 4 }

  private
  def upcase_indices
    department.upcase!
  end
end
