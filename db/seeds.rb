require 'factory_girl_rails'

20.times do
  book = FactoryGirl.create(:book, :with_single_course)
end
