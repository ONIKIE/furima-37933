class ProductsController < ApplicationController
  def index
    @products = Product.order('created_at DESC')
  end

  def new
  end

  def create
  end


end
