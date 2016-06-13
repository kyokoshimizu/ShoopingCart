class CartDetailsController < ApplicationController
	def new
		if session[:shopping_cart_id] < 0
			session[:shopping_cart_id] = ShoppingCart.create_cart(session[:name], session[:member_id])
		end
		material_id = params[:id]
		@cart_detail = CartDetail.add(session[:shopping_cart_id], material_id)
	end
	
	def destroy
		cart_detail = CartDetail.find_by(shopping_cart_id: session[:shopping_cart_id], material_id: params[:id])
		@price = CartDetail.get_price(cart_detail, session[:shopping_cart_id])
		cart_detail.destroy
		@material_id = params[:id]
	end

	def edit
		@cart_detail = CartDetail.find(params[:id])
		@material_id = @cart_detail.material_id
	end

	def update
		cart_detail = CartDetail.find(params[:id])
		cart_detail.update(num_params)
		flash[:notice] = CartDetail.has_error?(cart_detail)
		redirect_to shopping_carts_path
	end

private
	def num_params
		params.require(:cart_detail).permit(:num)
	end
end