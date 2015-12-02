module Api
  module V1
    class FeedsController < ApplicationController
      def _feed_hash(feed) 
        {
          :id => feed.id,
          :title => feed.title,
          :status => feed.status,
          :url => feed.url,
          :subscribed => feed.subscribed
        }
      end

      def index
        render :json => Feed.all.map do |feed|
          _feed_hash feed
        end
      end

      def show
        if Feed.exists?(params[:id])
          render :json => _feed_hash(Feed.find(params[:id]))
        else
          render :json => params, :status => :not_found
        end
      end

      def create
        if params["url"].nil?
          render :json => params, :status => :not_acceptable
        else
          @feed = Feed.create(
            :url => params["url"]
          )

          FeedHelper.subscribe(@feed)

          render :json => _feed_hash(@feed)
        end
      end

      def destroy
        if Feed.exists?(params[:id])
          @feed = Feed.find(params[:id])

          FeedHelper.unsubscribe(@feed)

          @feed.destroy

          render :json => _feed_hash(@feed)
        else 
          render :json => params, :status => :not_found
        end
      end
    end
  end
end
