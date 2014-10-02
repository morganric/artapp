class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :display_name
      t.integer :user_id
      t.text :bio
      t.string :image
      t.date :dob
      t.string :location
      t.string :website

      t.timestamps
    end
  end
end
