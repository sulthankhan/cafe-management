class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.string :description
      t.boolean :is_primary

      t.timestamps
    end
  end
end
