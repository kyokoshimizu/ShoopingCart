class OrdersController < ApplicationController

	def index
		@member = Member.find(session[:member_id])
	end
	def register
		@name = session[:name]
		@materials = ShoppingCart.selected_matelials(session[:shopping_cart_id])
		@order, @path = Order.get_order(session[:name], session[:shopping_cart_id], session[:member_id])
		@payment_method = Order.get_method(@order.payment_method)
		@cart_details = CartDetail.where(shopping_cart_id: session[:shopping_cart_id])
	end

	def show
		@order = Order.find(params[:id])
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
		order = Order.new(order_params)
		order.shopping_cart_id, order.member_id = session[:shopping_cart_id], member_id
		if order.save
			redirect_to action: :register
		else
			@blank = Order.has_blank(params[:order])
			flash[:notice] = @blank.to_s + "ちゃんと入力してください"
			render 'new'
		end
	end

	def update
		@order = Order.find(params[:id])
		if @order.update(order_params)
			redirect_to action: 'register'
		else
			flash[:notice] = "すべてちゃんと入力してください"
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
		params.require(:order).permit(:name, :address, :payment_method, :phone_number)
	end

	def put_params
		member = Member.find(session[:member_id])
		params = { shopping_cart_id: session[:shopping_cart_id], name: member.self_information.name, address: member.self_information.address, payment_method: member.self_information.payment_method, phone_number: member.self_information.phone_number, decide_order: true, member_id: member.id }
	end
end