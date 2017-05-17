class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :order_details
  has_many :orders, through: :order_details
  has_many :wish_lists, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  has_attached_file :item
  validates_attachment_content_type :item,
    content_type: "application/zip"

  has_attached_file :image_product, styles: {medium: "300x300>",
    thumb: "100x100>"}, default_url: "default.png"
  validates_attachment_content_type :image_product,
    content_type: /\Aimage\/.*\z/
end
