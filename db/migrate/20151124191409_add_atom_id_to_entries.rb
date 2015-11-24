class AddAtomIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :atom_id, :string
  end
end
