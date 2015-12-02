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
        render :json => _feed_hash(Feed.find(params[:id]))
      end

      def create
        @feed = Feed.create(
          :url => params["url"]
        )

        @feed.subscribe(SuperfeedrEngine::Engine)

        render :json => _feed_hash(@feed)
      end
    end
  end
end
