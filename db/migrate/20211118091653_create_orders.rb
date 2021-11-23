class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.date :date
      t.bigint :user_id
      t.string :total_price
      t.string :delivered_at

      t.timestamps
    end
  end
end
