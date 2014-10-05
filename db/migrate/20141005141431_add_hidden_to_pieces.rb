class AddHiddenToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :hidden, :boolean
    add_column :pieces, :featured, :boolean
  end
end
