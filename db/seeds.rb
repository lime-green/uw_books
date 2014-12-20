require 'factory_girl_rails'

50.times do
  book = FactoryGirl.create(:book, :with_single_course)
end
