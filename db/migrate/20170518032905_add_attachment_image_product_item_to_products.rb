class AddAttachmentImageProductItemToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :image_product
      t.attachment :item
    end
  end

  def self.down
    remove_attachment :products, :image_product
    remove_attachment :products, :item
  end
end
