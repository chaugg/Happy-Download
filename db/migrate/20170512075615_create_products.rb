class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :link_preview
      t.text :title
      t.text :summary
      t.text :content
      t.decimal :price
      t.string :image_product

      t.timestamps
    end
    add_index :products, [:user_id, :created_at]
  end
end
