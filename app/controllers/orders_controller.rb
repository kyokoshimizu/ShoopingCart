class OrdersController < ApplicationController
	def index
		@member = Member.find(session[:member_id])
		@num = params[:id].to_i
		@difference = params[:difference].to_i
	end
	def register
		@materials = ShoppingCart.selected_matelials(session[:shopping_cart_id])
		@order, @path = Order.get_order(session[:name], session[:shopping_cart_id], session[:member_id])
		if @order.name #session[:name] != ""
			@payment_method = Order.get_method(@order.payment_method)
		end
		@cart_details = CartDetail.where(shopping_cart_id: session[:shopping_cart_id])
	end

	def show
		render 'members/error_page' if Order.find_by(id: params[:id]).class == NilClass || !Order.check_member(Order.find(params[:id]), session[:member_id])		
		@order = Order.find(params[:id])
		@cart_details = CartDetail.where(shopping_cart_id: @order.shopping_cart_id)
		@payment_method = Order.get_method(@order.payment_method)
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
		if @change_order.payment_method == 3
			@card_info = CardInfo.new(card_params(params))
			@card_info.valid?
		end
		if @change_order.save
			if @change_order.payment_method == 3
				@card_info.order_id = @change_order.id
				@card_info.save
			end
			redirect_to action: :register
		else
			render 'new'
		end
	end

	def update
		@change_order = Order.find(params[:id])
		if @change_order.update(order_params)
			CardInfo.re_create_order(params, params[:id]) if @change_order.payment_method == 3
			redirect_to action: 'register'
		else
			render 'edit'
		end
	end

	def decide
		order = Order.find_by(shopping_cart_id: session[:shopping_cart_id])
		if !order
			order = Order.new(put_params)
			self_information_id = Member.find(session[:member_id]).self_information.id
		else
			order_id = order.id
		end
		if order.payment_method == 3 && ( !CardInfo.check_info(self_information_id, order_id) || !CardInfo.check_deadline(self_information_id, order_id) )
			flash[:notice] = "カード情報に誤りがあります"
			redirect_to action: 'register'#controller: :members, action: 'error_page'
		else
			order.decide_order = true
			order.save
		end
	end
private
	def order_params
		params.require(:order).permit(:name, :address, :postal, :payment_method, :phone_number)
	end

	def put_params
		member = Member.find(session[:member_id])
		params = { shopping_cart_id: session[:shopping_cart_id], name: member.self_information.name, address: member.self_information.address, postal: member.self_information.postal, payment_method: member.self_information.payment_method, phone_number: member.self_information.phone_number, decide_order: false, member_id: member.id }
	end
	def card_params(params)
		card_params = { card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code] }
	end
end