class ProductsController < ApplicationController
  before_action :find_product, except: [:index, :create, :new]
  before_action :categories, only: [:new, :edit]
  before_action :authenticate_user!, except: :index

  def index
    @products = Product.paginate page: params[:page]
    if params[:tag]
      @products = Product.tagged_with(params[:tag])
    end
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
    @product.destroy
    respond_to do |format|
      format.html{redirect_to products_url, notice: t(".success")}
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
    params.require(:product).permit :category_id, :title, :summary, :content,
      :price, :image_product, :item, :tag_list
  end
end
