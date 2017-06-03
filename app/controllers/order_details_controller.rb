class OrderDetailsController < ApplicationController
  before_action :authenticate_user!

  def new
    @order_detail = OrderDetail.new
    @product = Product.find_by id: params[:product_id]
  end

  def create
    @product = Product.find_by id: params[:product_id]
    @order_detail = OrderDetail.new order_detail_params
    get_buyer_cash
    tranfer_cash_to_seller
    if @order_detail.save
      NotificationService.new(action: @order_detail, notice_type: "buy",
        current_user: current_user).create_notification
      respond_to do |format|
        format.html{redirect_to @product, notice: t(".order_save_success")}
        format.js
      end
    else
      render :new
    end
  end

  private
  def get_buyer_cash
    Stripe.api_key = ENV["STRIPE_API_KEY"]
    begin
      Stripe::Charge.create(
        amount: (@product.price * 100).floor,
        currency: "usd",
        customer: Stripe::Customer.create(source: params[:stripeToken])
      )
    rescue Stripe::CardError => error
      flash[:danger] = error.message
    end
  end

  def tranfer_cash_to_seller
    Stripe::Transfer.create(
      amount: (@product.price * 95).floor,
      currency: "usd",
      destination: @product.user.recipient
    )
  end

  def order_detail_params
    params.require(:order_detail).permit :note, :product_id,
      :seller_id, :buyer_id
  end
end
