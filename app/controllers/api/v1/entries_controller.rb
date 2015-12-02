
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
        render :json => _entry_hash(Entry.find(params[:id]))
      end
    end
  end 
end
