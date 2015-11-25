class FeedController < ApplicationController
  def show
    @feed = Feed.find(params[:id])
  end
end
