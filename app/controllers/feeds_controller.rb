class FeedsController < ApplicationController
  def show
    @feed = Feed.find(params[:id])
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.create(
      :url => params[:feed][:url],
      :title => params[:feed][:title]
    )
    if @feed.subscribe(SuperfeedrEngine::Engine)
      redirect_to @feed, notice: "Success!"
    else
      redirect_to @feed, notice: "Failed to subscribe"
    end
  end
end
