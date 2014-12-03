class AddViewsToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :views, :integer, :default => 0
    add_column :collections, :description, :text
  end
end
