class PhotoNotNull < ActiveRecord::Migration
  def change
    change_column :photos, :url, :string, null: false
  end
end
