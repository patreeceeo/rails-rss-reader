class AddContentToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :content, :string
  end
end
