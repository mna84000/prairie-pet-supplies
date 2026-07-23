class ProductsController < ApplicationController
  def index
  @categories = Category.order(:name)

  @products = Product.includes(:category)
                     .where(active: true)

  if params[:query].present?
    keyword = "%#{ActiveRecord::Base.sanitize_sql_like(params[:query])}%"

    @products = @products.where(
      "products.name ILIKE :keyword OR products.description ILIKE :keyword",
      keyword: keyword
    )
  end

  if params[:category_id].present?
    @products = @products.where(category_id: params[:category_id])
  end

  @products = @products.order(created_at: :desc)
                       .page(params[:page])
                       .per(12)
end
  def show
    @product = Product.includes(:category).find(params[:id])
  end
end
