class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
    add_index :collections, [:user_id, :title], :unique => true
  end
end
