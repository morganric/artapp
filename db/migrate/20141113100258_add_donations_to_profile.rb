class AddDonationsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :donations, :boolean
  end
end
