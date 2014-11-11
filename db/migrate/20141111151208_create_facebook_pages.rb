class CreateFacebookPages < ActiveRecord::Migration
  def change
    create_table :facebook_pages do |t|
      t.string :fb_page_id
      t.integer :user_id

      t.timestamps
    end
    add_index :facebook_pages, :fb_page_id, unique: true
    add_index :facebook_pages, [:fb_page_id, :user_id], unique: true
  end
end
