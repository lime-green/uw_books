require 'rails_helper'

RSpec.describe Course, :type => :model do
  it "has a valid factory" do
    factory = FactoryGirl.create(:course)
    expect(factory).to be_valid, lambda { factory.errors.full_messages.join("\n") }
  end

  it "allows no null values"
end
