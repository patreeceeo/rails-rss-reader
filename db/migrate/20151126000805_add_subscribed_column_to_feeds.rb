class AddSubscribedColumnToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :subscribed, :boolean
  end
end
