describe Api::V1::FeedsController, :api => true do

  let(:response_data) do
    JSON.parse(response.body)
  end

  describe "POST #create w: GOOD DATA" do
    before do
      expect(FeedHelper).to receive(:subscribe).with(instance_of(Feed))

      @feed_data = {
        "url" => "http://braindumps.org",
        "title" => "22 hot new hairstyles for your yak"
      }

      post :create, @feed_data
    end

    it "returns HTTP success" do
      expect(response).to have_http_status(:success)
    end

    it "records the feed" do
      expect(Feed.find(response_data["id"]).title).to eq response_data["title"]
    end
  end

  describe "POST #create w: NO URL" do
    before do
      expect(FeedHelper).not_to receive(:subscribe).with(instance_of(Feed))
      @feed_data = {
        title: "22 hot new hairstyles for your yak"
      }

      post :create, @feed_data
    end

    it "returns HTTP not acceptable" do
      expect(response).to have_http_status(:not_acceptable)
    end

    it "does not records the feed" do
      expect do 
        Feed.find(response_data["id"])
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "GET #show w: GOOD DATA" do
    before do
      @feed_data = {
        "id" => 22,
        "title" => "22 hot new hair styles for your yak",
        "status" => "mkay",
        "url" => "http://braindumps.org",
        "subscribed" => true
      }
      Feed.create @feed_data
      get :show, {:id => 22}
    end

    it "returns HTTP not found" do
      expect(response).to have_http_status(:success)
    end

    it "returns JSON representing the feed" do
      expect(response_data).to eq @feed_data
    end
  end

  describe "GET #show w: BAD ID" do
    before do
      @feed_data = {
        "id" => 22,
        "title" => "22 hot new hair styles for your yak",
        "status" => "mkay",
        "url" => "http://braindumps.org",
        "subscribed" => true
      }
      Feed.create @feed_data
      get :show, {:id => 11}
    end

    it "returns HTTP not found" do
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET #index" do
    before do
      @feed_data = {
        "id" => 22,
        "title" => "22 hot new hair styles for your yak",
        "status" => "mkay",
        "url" => "http://braindumps.org",
        "subscribed" => true
      }
      Feed.create @feed_data
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of feeds" do
      expect(response_data).to be_an Array
    end
  end

  describe "DELETE #destroy w: GOOD DATA" do
    before do
      expect(FeedHelper).to receive(:unsubscribe).with(instance_of(Feed))
      @feed_data = {
        "id" => 22,
        "title" => "22 hot new hair styles for your yak",
        "status" => "mkay",
        "url" => "http://braindumps.org",
        "subscribed" => true
      }
      Feed.create @feed_data
      delete :destroy, {:id => 22}
    end

    it "erases the feed record" do
      expect do 
        Feed.find(22) 
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "DELETE #destroy w: BAD ID" do
    before do
      expect(FeedHelper).not_to receive(:unsubscribe).with(instance_of(Feed))
      @feed_data = {
        "id" => 22,
        "title" => "22 hot new hair styles for your yak",
        "status" => "mkay",
        "url" => "http://braindumps.org",
        "subscribed" => true
      }
      Feed.create @feed_data
      delete :destroy, {:id => 11}
    end

    it "returns HTTP not found" do
      expect(response).to have_http_status(:not_found)
    end
  end
end
