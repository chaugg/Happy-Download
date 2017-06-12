class ProductsController < ApplicationController
  before_action :find_product, except: [:index, :create, :new]
  before_action :categories, only: [:new, :edit, :update, :create]
  before_action :authenticate_user!, except: :index

  def index
    @categories = Category.all
    category_id = params[:id]
    @products =
      if params[:query]
        Product.category(category_id).active.search params[:query],
          suggest: true, page: params[:page],
          per_page: Settings.paginate.per_page_search
      else
        Product.category(category_id).active.paginate page: params[:page],
          per_page: Settings.paginate.per_page_search
      end
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build product_params
    create_recipient_user if current_user.recipient.blank?
    if @product.save
      redirect_to @product, notice: t(".success")
    else
      render :new
    end
  end

  def show
    @feedback = current_user.feedbacks.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @product.update_attributes product_params
        format.html{redirect_to @product, notice: t(".success")}
        format.json{render :show, status: :ok, location: @product}
      else
        format.html{render :edit}
        format.json{render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @product.deactive!
    respond_to do |format|
      format.html{redirect_to :back, notice: t(".success")}
      format.json{head :no_content}
    end
  end

  private
  def find_product
    @product = Product.find_by id: params[:id]
    if @product
    else
      redirect_to root_url, notice: t(".not_found")
    end
  end

  def categories
    @categories = Category.all
  end

  def product_params
    params.require(:product).permit :category_id, :title, :summary,
      :link_preview, :content, :price, :image_product, :item
  end

  def create_recipient_user
    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]
    recipient = Stripe::Account.create(
      type: "custom",
      bank_account: token
    )
    current_user.recipient = recipient.id
    current_user.save
  end
end
