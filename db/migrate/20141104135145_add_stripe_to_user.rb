class AddStripeToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_secret_key, :string
    add_column :users, :stripe_publishable_key, :string
  end
end
