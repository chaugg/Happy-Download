class Product < ApplicationRecord
  validates :item_fingerprint, :uniqueness => { :message => "Image has already been uploaded." }
  searchkick suggest: [:title], special_characters: false

  belongs_to :user
  belongs_to :category

  has_many :order_details
  has_many :orders, through: :order_details
  has_many :wish_lists, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :notifications, as: :notificationable

  ratyrate_rateable "quality"

  has_attached_file :item
  validates_attachment_content_type :item,
    content_type: "application/zip",
    adapter_options: {hash_digest: Digest::SHA256}

  has_attached_file :image_product, styles: {medium: "300x300>",
    thumb: "100x100>"}, default_url: "default.png", use_timestamp: "false",
    hash_secret: "AnhChiThichAnChao_DoChinhTayEmNau",
    adapter_options: {hash_digest: Digest::SHA256},
    s3_host_name: "s3-ap-southeast-1.amazonaws.com"
  validates_attachment_content_type :image_product,
    content_type: /\Aimage\/.*\z/
end
