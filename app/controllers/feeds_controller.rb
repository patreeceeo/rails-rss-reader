class FeedsController < ApplicationController
  def show
    @feed = Feed.find(params[:id])
  end

  def new
    @feed = Feed.new
  end

  def create
    Feed.create(:url => params[:feed][:url])
  end
end
