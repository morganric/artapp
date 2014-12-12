class AddInboxToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :inbox, :boolean, :default => true
  end
end
