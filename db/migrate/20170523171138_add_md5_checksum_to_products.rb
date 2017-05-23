class AddMd5ChecksumToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :md5_checksum, :text
  end
end
