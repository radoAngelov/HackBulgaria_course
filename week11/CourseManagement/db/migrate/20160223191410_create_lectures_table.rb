class CreateLecturesTable < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :name
      t.text :body
      t.timestamps null: false
    end
  end
end
