require 'rails_helper'

RSpec.describe Feed, type: :model do
  before do
    @feed = Feed.new(
      :url => "food.com"
    )
  end

  describe "#secret" do
    before do
      @other_feed = Feed.new(
        :url => "moo.com"
      )
    end

    it "is unique per feed" do
      expect(@feed.secret).not_to eq @other_feed.secret
    end
  end

  describe "#notified" do
    before do
      @feed.notified(
        "status" => { "http" => "super" },
        "items" => [
          {
            "id" => 1,
            "title" => "How to become a millionaire",
            "permalinkUrl" => "http://money.com",
            "content" => "Yadda Yadda"
          },
          {
            "id" => 2,
            "title" => "20 reasons listicles suck",
            "permalinkUrl" => "http://cats.com",
            "content" => "Yadda Yadda"
          }
        ]
      )
    end

    it "updates the status" do
      expect(@feed.status).to eq "super"
    end

    it "creates new entries" do
      expect(@feed.entries.length).to be 2
    end
  end
end
