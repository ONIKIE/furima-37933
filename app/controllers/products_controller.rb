class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update]

  def index
    @products = Product.all.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    end

  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      render 'edit'
    end
  end

  private


  def product_params
    params.require(:product).permit(:image, :name, :explanation, :category_id, :shipping_fee_id, :status_id, :prefecture_id,
                                    :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def ensure_current_user
    product = Product.find(params[:id])
    if product.user_id != current_user.id
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
