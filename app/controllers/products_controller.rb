class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update]

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

  def destroy
    if current_user.id == @product.user_id
      @product.destroy
      redirect_to root_path
    else
      redirect :show
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :name, :explanation, :category_id, :shipping_fee_id, :status_id, :prefecture_id,
                                    :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def ensure_correct_user
    unless @product.user.id == current_user.id
      redirect_to root_path
    end
  end
end
