class CreateCollectionPieces < ActiveRecord::Migration
  def change
    create_table :collection_pieces do |t|
      t.integer :piece_id
      t.integer :collection_id

      t.timestamps
    end
    add_index :collection_pieces, [:collection_id, :piece_id], :unique => true
  end
end
