class PostNotNull < ActiveRecord::Migration
  def change
    change_column :posts, :name, :string, null: false
    change_column :posts, :content, :text , null: false
  end
end
