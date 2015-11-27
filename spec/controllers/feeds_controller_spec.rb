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
      post :create, :feed => { :url => "http://foo.com" }
      @feed = Feed.find_by_url("http://foo.com")
    end

    it "creates a new feed" do
      expect(@feed).not_to eq nil
    end

    it "redirects to feed#show" do
      expect(response).to redirect_to @feed
    end

    it "subscribes to the actual feed" do
    end
  end
end
