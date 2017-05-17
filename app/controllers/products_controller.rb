class ProductsController < ApplicationController
  helper_method :user_product
  before_action :find_product, except: [:index, :create, :new]
  before_action :categories, only: [:new, :edit]
  before_action :authenticate_user!, except: [:show]

  def index
    @products = Product.all
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build product_params
    respond_to do |format|
      if @product.save
        format.html{redirect_to @product, notice: t(".success")}
        format.json{render :show, status: :created, location: @product}
      else
        format.html{render :new}
        format.json{render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @product.update product_params
        format.html{redirect_to @product, notice: t(".success")}
        format.json{render :show, status: :ok, location: @product}
      else
        format.html{render :edit}
        format.json{render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html{redirect_to products_url, notice: t(".success")}
      format.json{head :no_content}
    end
  end

  private
  def user_product
    current_user == @product.user
  end

  def find_product
    @product = Product.find_by id: params[:id]
    if @product.blank?
      redirect_to root_url, notice: t(".not_found")
    else
      @product
    end
  end

  def categories
    @categories = Category.all
  end

  def product_params
    params.require(:product).permit :category_id, :title, :summary, :content,
      :price, :image_product, :item
  end
end
