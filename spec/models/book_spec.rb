describe Book do
  it "has a valid factory" do
    factory = FactoryGirl.build(:book)
    expect(factory).to be_valid, lambda { factory.errors.full_messages.join("\n") }
  end

  it "allows no null values"
end
