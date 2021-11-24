class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.bigint :user_id
      t.float :total_price
      t.string :status

      t.timestamps
    end
  end
end
