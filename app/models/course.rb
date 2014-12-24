class Course < ActiveRecord::Base
  before_validation :upcase_indices
  default_scope lambda { order(department: :asc, number: :asc, section: :asc) }
  has_and_belongs_to_many :books

  validates :instructor, length: { maximum: 255 }, uniqueness: { scope: [:department, :number, :term, :section] }

  validates :section,    presence: true, allow_blank: false, length: { is: 3 }
  validates :department, presence: true, allow_bank:  false, length: { in: 2..10 }
  validates :number,  presence: true, allow_bank: false
  validates :term, presence: true, length: { is: 4 }

  private
  def upcase_indices
    department.upcase!
  end
end
