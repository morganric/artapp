class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :piece_id
      t.float :amount
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end
end
