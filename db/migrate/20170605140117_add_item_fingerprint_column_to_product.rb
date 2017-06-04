class AddItemFingerprintColumnToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :item_fingerprint, :string
  end
end
