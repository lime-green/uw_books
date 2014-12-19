require 'rails_helper'

RSpec.describe Book, :type => :model do

  context "validations" do
    let (:book) { FactoryGirl.create(:book) }

    %w(author title).each do |attribute|
      context attribute do
        it "can't be blank or empty" do
          book[attribute] = ""
          expect(book).not_to be_valid
          book[attribute] = "   "
          expect(book).not_to be_valid
        end

        it "can't be longer than 255 characters" do
          book[attribute] = "a" * 256
          expect(book).not_to be_valid
        end

        it "correctly validates" do
          book[attribute] = "Orson Scott-Card"
          expect(book).to be_valid
        end
      end
    end

    %w(price stock).each do |attribute|
      context attribute do
        it "can't be empty" do
          book[attribute] = ""
          expect(book).not_to be_valid
        end

        it "can't be negative" do
          book[attribute] = -5
          expect(book).not_to be_valid
        end

        it "correctly validates" do
          book[attribute] = 5
          expect(book).to be_valid
        end
      end
    end

    context "sku" do
      it "can't be empty" do
        book.sku = ""
        expect(book).not_to be_valid
      end

      it "can't be less than 13 digits" do
        book.sku = 1
        expect(book).not_to be_valid
      end

      it "can't be more than 13 digits" do
        book.sku = 10**13
        expect(book).not_to be_valid
      end

      it "must be 13 digits" do
        book.sku = 10**12
        expect(book).to be_valid
      end
    end

    context "reqopt" do
      it "correctly validates" do
        book.reqopt = true
        expect(book).to be_valid
      end
    end
  end
end
