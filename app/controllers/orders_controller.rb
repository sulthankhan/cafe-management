class OrdersController < ApplicationController
  def index
    if @current_user.role == "Admin"
      @orders = Order.order(created_at: :desc)
      render "manage"
    else
      @orders = @current_user.orders.order(created_at: :desc)
      render "index"
    end
  end

  def update
    order = Order.find(params[:id])
    order.delivered_at = DateTime.now
    order.save
    redirect_to orders_path
  end

  def create
    order = Order.create!({
      user_id: @current_user.id,
      total_price: @cart.total_price,
      date: DateTime.now,
    })
    @cart.cart_items.each do |item|
      OrderItem.create!({
        order_id: order.id,
        menu_item_id: item.menu_item_id,
        menu_item_name: item.menu_item_name,
        menu_item_price: item.menu_item_price,
        quantity: item.quantity,
      })
    end

    @cart.cart_items.destroy_all
    @cart.total_price = 0
    @cart.save

    redirect_to order_path(order.id)
  end

  def show
    @order = Order.find_by(id: params[:id], user_id: @current_user.id)
    @order = Order.find_by(id: params[:id]) if @current_user.role == "Admin"
    render "show"
  end
end
