class AddImageMd5ToProducts < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :image_fingerprint, :string
  end

  def down
    remove_column :users, :image_fingerprint
  end
end
