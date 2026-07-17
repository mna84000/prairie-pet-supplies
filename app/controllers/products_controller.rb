class ProductsController < ApplicationController
  def index
    @categories = Category.order(:name)
    @products = Product.includes(:category)
                       .where(active: true)
                       .order(created_at: :desc)
  end

  def show
    @product = Product.includes(:category).find(params[:id])
  end
end
