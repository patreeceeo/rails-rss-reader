describe Api::V1::EntriesController, :api => true do
  describe "GET #show w: GOOD DATA" do
    before do
      @feed_data = {
        "id" => 22
      }
      Feed.create @feed_data
      @entry_data = {
        "id" => 7,
        "feed_id" => 22,
        "title" => "22 hot new hair styles for your yak",
        "url" => "http://braindumps.org",
        "content" => "Is your yak a hairy prima donna?"
      }
      Feed.create @feed_data
      Entry.create @entry_data
      get :show, {:feed_id => 22, :id => 7}
    end

    let(:response_data) do
      JSON.parse(response.body)
    end

    it "returns HTTP success" do
      expect(response).to have_http_status(:success)
    end

    it "returns JSON representing the entry" do
      expect(response_data).to eq @entry_data
    end
  end

  describe "GET #show w: BAD ID" do
    before do
      @feed_data = {
        "id" => 22
      }
      Feed.create @feed_data
      @entry_data = {
        "id" => 7,
        "feed_id" => 22,
        "title" => "22 hot new hair styles for your yak",
        "url" => "http://braindumps.org",
        "content" => "Is your yak a hairy prima donna?"
      }
      Feed.create @feed_data
      Entry.create @entry_data
      get :show, {:feed_id => 22, :id => 11}
    end

    let(:response_data) do
      JSON.parse(response.body)
    end

    it "returns HTTP not found" do
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET #index" do
    before do
      @feed_data = {
        "id" => 22
      }
      Feed.create @feed_data
      @entry_data = {
        "id" => 7,
        "feed_id" => 22,
        "title" => "22 hot new hair styles for your yak",
        "url" => "http://braindumps.org",
        "content" => "Is your yak a hairy prima donna?"
      }
      Feed.create @feed_data
      Entry.create @entry_data
      get :index, {:feed_id => 22}
    end

    let(:response_data) do
      JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of entries" do
      expect(response_data).to be_an Array
    end
  end
end
