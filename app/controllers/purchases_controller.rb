class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]

  def index
    if @product[:user_id] == current_user.id || @product.purchase.present?
      redirect_to root_path
    else
      @purchase = PurchaseAddress.new
    end
  end

  def create
    @purchase = PurchaseAddress.new(purchase_params) 
  end


  private

  def purchase_params
    params.require(:purchase_address).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, product_id: params[:product_id],token: params[:token])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end


end
