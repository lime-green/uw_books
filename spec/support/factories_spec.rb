require 'rails_helper'

# goes through each factory and trait and checks that the factory creates valid objects
describe "Factory Girl" do
  FactoryGirl.factories.map(&:name).each do |factory_name|
    describe "#{factory_name} factory" do
      # Test each factory
      it "is valid" do
        factory = FactoryGirl.build(factory_name)
        if factory.respond_to?(:valid?)
          expect(factory).to be_valid, lambda { factory.errors.full_messages.join("\n") }
        end
      end

      # Test each trait
      FactoryGirl.factories[factory_name].definition.defined_traits.map(&:name).each do |trait_name|
        context "with trait #{trait_name}" do
          it "is valid" do
            factory = FactoryGirl.create(factory_name, trait_name)
            if factory.respond_to?(:valid?)
              expect(factory).to be_valid, lambda { factory.errors.full_messages.join("\n") }
            end
          end
        end
      end

    end
  end

  # specific factories
  describe "#book factory" do
    it "creates NO courses when no trait given" do
      FactoryGirl.create(:book)
      expect(Course.all.length).to eq(0)
    end
    context "trait #with_single_course" do
      it "only creates a single course" do
        FactoryGirl.create(:book, :with_single_course)
        expect(Course.all.length).to eq(1)
      end
    end

  end
end
