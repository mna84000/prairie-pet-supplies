class CheckoutController < ApplicationController
  before_action :load_cart, only: %i[new create]

  def new
    redirect_to cart_path, alert: "Your cart is empty." and return if @cart_items.empty?

    @customer = Customer.new
    @provinces = Province.order(:name)
    @subtotal = calculate_subtotal
  end

  def create
    redirect_to cart_path, alert: "Your cart is empty." and return if @cart_items.empty?

    @customer = Customer.new(customer_params)
    @provinces = Province.order(:name)
    @subtotal = calculate_subtotal

    unless @customer.valid?
      render :new, status: :unprocessable_entity
      return
    end

    province = @customer.province

    gst_amount = (@subtotal * province.gst).round(2)
    pst_amount = (@subtotal * province.pst).round(2)
    hst_amount = (@subtotal * province.hst).round(2)
    total_amount = (@subtotal + gst_amount + pst_amount + hst_amount).round(2)

    ActiveRecord::Base.transaction do
      @customer.save!

      @order = @customer.orders.create!(
        subtotal: @subtotal,
        gst: gst_amount,
        pst: pst_amount,
        hst: hst_amount,
        total: total_amount,
        status: "completed"
      )

      @cart_items.each do |item|
        @order.order_items.create!(
          product: item[:product],
          quantity: item[:quantity],
          unit_price: item[:product].price
        )
      end
    end

    session[:cart] = {}

    redirect_to invoice_path(@order)
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = "The order could not be completed."
    render :new, status: :unprocessable_entity
  end

  def show
    @order = Order.includes(
      :customer,
      order_items: :product
    ).find(params[:id])
  end

  private

  def load_cart
    cart = session[:cart] || {}

    @cart_items = cart.filter_map do |product_id, quantity|
      product = Product.find_by(id: product_id)

      next unless product

      {
        product: product,
        quantity: quantity.to_i
      }
    end
  end

  def calculate_subtotal
    @cart_items.sum do |item|
      item[:product].price * item[:quantity]
    end
  end

  def customer_params
    params.require(:customer).permit(
      :first_name,
      :last_name,
      :email,
      :address,
      :city,
      :postal_code,
      :province_id
    )
  end
end
