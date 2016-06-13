class OrdersController < ApplicationController
	def index
		@member = Member.find(session[:member_id])
	end
	def register
		@name = session[:name]
		@materials = ShoppingCart.selected_matelials(session[:shopping_cart_id])
		@order, @path = Order.get_order(session[:name], session[:shopping_cart_id], session[:member_id])
		if @name != ""
			@payment_method = Order.get_method(@order.payment_method)
		end
		@cart_details = CartDetail.where(shopping_cart_id: session[:shopping_cart_id])
	end

	def show
		render 'members/error_page' if Order.find_by(id: params[:id]).class == NilClass || !Order.check_member(Order.find(params[:id]), session[:member_id])		
		@order = Order.find_by(params[:id])
		@cart_details = CartDetail.where(shopping_cart_id: @order.shopping_cart_id)
		@name = session[:name]
	end

	def new
		@change_order = Order.new
	end

	def edit
		@change_order = Order.find(params[:id])
	end

	def create
		member_id = Member.find_member(session[:member_id], session[:name])
		@change_order = Order.new(order_params)
		@change_order.shopping_cart_id, @change_order.member_id = session[:shopping_cart_id], member_id
		if @change_order.save
			redirect_to action: :register
		else
			render 'new'
		end
	end

	def update
		@change_order = Order.find(params[:id])
		if @change_order.update(order_params)
			redirect_to action: 'register'
		else
			render 'edit'
		end
	end

	def decide
		order = Order.find_by(shopping_cart_id: session[:shopping_cart_id])
		if !order
			order = Order.new(put_params)
		else
			order.decide_order = true
		end
		order.save
	end
private
	def order_params
		params.require(:order).permit(:name, :address, :postal, :payment_method, :phone_number)
	end

	def put_params
		member = Member.find(session[:member_id])
		params = { shopping_cart_id: session[:shopping_cart_id], name: member.self_information.name, address: member.self_information.address, postal: member.self_information.postal, payment_method: member.self_information.payment_method, phone_number: member.self_information.phone_number, decide_order: true, member_id: member.id }
	end
end