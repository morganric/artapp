class AddTwitterToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :twitter, :string
    add_column :profiles, :banner, :string
  end
end
