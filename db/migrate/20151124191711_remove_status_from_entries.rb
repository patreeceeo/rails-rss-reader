class RemoveStatusFromEntries < ActiveRecord::Migration
  def change
    remove_column :entries, :status, :string
  end
end
