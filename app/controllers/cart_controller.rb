class CartController < ApplicationController
  def show
    cart = session[:cart] || {}

    product_ids = cart.keys
    @products = Product.where(id: product_ids)

    @cart_items = @products.map do |product|
      {
        product: product,
        quantity: cart[product.id.to_s].to_i
      }
    end
  end

  def add
    product = Product.find(params[:product_id])

    session[:cart] ||= {}
    product_id = product.id.to_s

    session[:cart][product_id] =
      session[:cart].fetch(product_id, 0) + 1

    redirect_to cart_path,
                notice: "#{product.name} was added to your cart."
  end

  def update
    session[:cart] ||= {}

    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    if quantity >= 1
      session[:cart][product_id] = quantity
      redirect_to cart_path,
                  notice: "Cart quantity was updated."
    else
      redirect_to cart_path,
                  alert: "Quantity must be at least 1."
    end
  end

  def remove
    session[:cart] ||= {}

    session[:cart].delete(params[:product_id].to_s)

    redirect_to cart_path,
                notice: "Product was removed from your cart."
  end
end
