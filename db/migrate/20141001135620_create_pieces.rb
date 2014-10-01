class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :title
      t.string :image
      t.text :description
      t.text :dimensions
      t.integer :views
      t.integer :user_id
      t.float :price
      t.boolean :sold

      t.timestamps
    end
  end
end
