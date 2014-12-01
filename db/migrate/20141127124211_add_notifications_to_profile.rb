class AddNotificationsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :notifications, :boolean, default: true
  end
end
