class FixRememberDigestColumn < ActiveRecord::Migration
  def change
    rename_column :users, :remeber_digest, :remember_digest
  end
end
