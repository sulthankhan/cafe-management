class MenuItemsController < ApplicationController
  def destroy
    menu_item = MenuItem.find(params[:id])
    menu_item.destroy
    redirect_to menu_path(params[:menu_id])
  end
end
