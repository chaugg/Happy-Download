class User < ApplicationRecord
  searchkick
  ratyrate_rater

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_one :profile, dependent: :destroy
  has_many :wish_lists, dependent: :destroy
  has_many :wish_products, through: :wish_lists, source: :product
  has_many :feedbacks, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :sales, class_name: OrderDetail.name, foreign_key: "seller_id"
  has_many :purchases, class_name: OrderDetail.name, foreign_key: "buyer_id"
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  has_many :notifications, dependent: :destroy

  def wish? product
    wish_products.include? product
  end
end
