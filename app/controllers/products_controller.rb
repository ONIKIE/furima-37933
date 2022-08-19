class ProductsController < ApplicationController
  before_action :require_login, only: :new, alert: 'You need to sign in or sign up before continuing.'

  def index
    # @products = Product.all.order('created_at DESC')
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

  private

  def require_login
    redirect_to user_session_path, alert: 'You need to sign in or sign up before continuing.' unless user_signed_in?
  end

  def product_params
    params.require(:product).permit(:image, :name, :explanation, :category_id, :shipping_fee_id, :status_id, :prefecture_id,
                                    :day_id, :price).merge(user_id: current_user.id)
  end
end
