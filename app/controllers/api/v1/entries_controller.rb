
module Api
  module V1
    class EntriesController < ApplicationController
      def _entry_hash(entry) 
        {
          :id => entry.id,
          :feed_id => entry.feed_id,
          :title => entry.title,
          :url => entry.url,
          :content => entry.content
        }
      end

      def index
        render :json => Entry.all.map do |entry|
          _entry_hash entry
        end
      end

      def show
        if Entry.exists?(params[:id])
          render :json => _entry_hash(Entry.find(params[:id]))
        else
          render :json => params, :status => :not_found
        end
      end
    end
  end 
end
