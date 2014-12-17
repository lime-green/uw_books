require 'factory_girl_rails'

20.times do
  book = FactoryGirl.create(:book)
  course = FactoryGirl.create(:course)
  course.books << book
  course.save
end
