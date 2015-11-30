module Api
  module V1
    class FeedsController < Api::ApplicationController
      def show
        @feed = Feed.find(params[:id])
        render :json => { 
          :id => @feed.id,
          :title => @feed.title,
          :status => @feed.status,
          :url => @feed.url
        }
      end

      def create
        @feed = Feed.create(
          :url => params["url"]
        )

        @feed.subscribe(SuperfeedrEngine::Engine)

        render :json => {
          :id => @feed.id,
          :title => @feed.title,
          :status => @feed.status,
          :subscribed => @feed.subscribed
        }
      end
    end
  end
end
