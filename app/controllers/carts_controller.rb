class CartsController < ApplicationController
  def update
    cart_id = params[:id]
    item_id = params[:item_id]
    item_name = params[:item_name]
    item_price = params[:item_price].to_f
    cart = Cart.find(cart_id)

    item_in_cart = CartItem.find_by({ menu_item_id: item_id })
    if item_in_cart && params[:op] == "REDUCE"
      item_in_cart.quantity -= 1
      cart.total_price -= item_in_cart.menu_item_price
      cart.save
      if item_in_cart.quantity < 1
        item_in_cart.destroy
        redirect_to menus_path
      else
        item_in_cart.save
        redirect_to menus_path
      end
    elsif item_in_cart
      item_in_cart.quantity += 1
      cart.total_price += item_in_cart.menu_item_price
      cart.save
      item_in_cart.save
      redirect_to menus_path
    else
      cartItem = CartItem.new({
        cart_id: cart_id,
        menu_item_id: item_id,
        menu_item_name: item_name,
        menu_item_price: item_price,
        quantity: 1,
      })

      if cartItem.save
        cart.total_price += item_price
        cart.save
        redirect_to menus_path
      else
        flash[:error] = cartItem.errors.full_messages.join(", ")
        redirect_to menus_path
      end
    end
  end
end
