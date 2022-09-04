class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create, :pay_item]

  def index
    if @product[:user_id] == current_user.id || @product.purchase.present?
      redirect_to root_path
    else
      @purchase = PurchaseAddress.new
    end
  end

  def create
    @purchase = PurchaseAddress.new(purchase_params)

    if @purchase.valid?
      pay_item
      @purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :municipality, :building_name, :address, :phone_number).merge(
      user_id: current_user.id, product_id: params[:product_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @product.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
