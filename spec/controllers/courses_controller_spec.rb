require 'rails_helper'

RSpec.describe Api::V1::CoursesController, :type => :controller do

  describe "#index" do
    it "has a 200 status code" do
      get :index, format: :json
      expect(response).to be_success
    end
  end

  describe "#show" do
    it "has a 200 status code" do
      get :index, format: :json
      expect(response).to be_success
    end
  end

end
