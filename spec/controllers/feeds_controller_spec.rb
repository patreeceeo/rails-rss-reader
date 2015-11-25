require 'rails_helper'

RSpec.describe FeedsController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show, {:id => 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    before do
      post :create, :feed => { :url => "foo.com" }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "creates a new feed" do
      expect(Feed.find_by_url("foo.com")).not_to eq nil
    end
  end
end
