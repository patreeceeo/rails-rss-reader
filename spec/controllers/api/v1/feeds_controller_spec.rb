describe Api::V1::FeedsController, :api => true do

  describe "POST #create" do
    before do
      expect_any_instance_of(Feed).to receive(:subscribe) do |feed|
        feed.update_attributes(
          :title => "22 hot new hair styles for your yak"
        )
      end

      @feed_data = {
        "url" => "http://braindumps.org"
      }

      post :create, @feed_data, :format => :json
    end

    let(:response_data) do
      JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "records the feed" do
      expect(Feed.find(response_data["id"]).title).to eq response_data["title"]
    end
  end

  describe "GET #show" do
    before do
      @feed_data = {
        "id" => 22,
        "title" => "22 hot new hair styles for your yak",
        "status" => "mkay",
        "url" => "http://braindumps.org",
        "subscribed" => true
      }
      Feed.create @feed_data
      get :show, {:id => 22}, :format => :json
    end

    let(:response_data) do
      JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns JSON representing the feed" do
      expect(response_data).to eq @feed_data
    end
  end

  describe "GET #index" do
    before do
      get :index
    end

    let(:response_data) do
      JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of feeds" do
      expect(response_data).to be_an Array
    end
  end
end
