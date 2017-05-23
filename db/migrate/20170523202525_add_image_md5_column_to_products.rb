class AddImageMd5ColumnToProducts < ActiveRecord::Migration[5.0]
  def self.up
    add_column :products, :image_fingerprint, :string
  end

  def down
    remove_column :products, :image_fingerprint
  end
end
