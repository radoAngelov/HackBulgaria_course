class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.decimal :price
      t.integer :quantity
    end
  end
end
