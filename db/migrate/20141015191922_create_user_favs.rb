class CreateUserFavs < ActiveRecord::Migration
  def change
    create_table :user_favs do |t|
      t.integer :user_id
      t.integer :piece_id

      t.timestamps
    end
  end
end
