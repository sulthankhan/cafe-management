class CartItem < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :cart
end
