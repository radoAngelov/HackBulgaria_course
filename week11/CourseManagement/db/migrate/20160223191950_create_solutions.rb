class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :answer
      t.timestamps null: false
    end
  end
end
