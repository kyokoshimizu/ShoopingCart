class ShoppingCartsController < ApplicationController
	def index
		@name = session[:name]
		@cart_details = CartDetail.where(shopping_cart_id: session[:shopping_cart_id])
	end
end