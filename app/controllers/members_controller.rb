class MembersController < ApplicationController
	def index
		session[:name] = ""
		session[:shopping_cart_id] = -1
		session[:member_id] = ""
		@id = session[:shopping_cart_id]
	end
	def new
		redirect_to edit_self_information_path(Member.find(session[:member_id]).self_information.id) if session[:name] != ""
		@member = Member.new
		@member.self_information = SelfInformation.new
	end

	def check_id
		if session[:member_id] != ""
			session[:shopping_cart_id] = -1
			session[:member_id] = ""
			session[:name] = ""
		end
		redirect_to materials_path
	end

	def create
		@member = Member.new(member_params)
		@member.self_information = SelfInformation.new(info_params)
		if @member.self_information.payment_method == '3'
			@card_info = CardInfo.new(card_params(params))
			@card_info.valid?
		end
			Member.transaction do
				@member.save!
				@member.self_information.save!
				@card_info.save! if @member.self_information.payment_method == '3'
			end
			@member.user_id = Member.create_user_id
			@member.save
		  if @member.self_information.payment_method == '3'
				@card_info.self_information_id = (Member.find(@member.id)).self_information.id
				@card_info.save
		  end
			flash[:msg] = "あなたのユーザーIDは、#{@member.user_id} です." 
			session[:shopping_cart_id] = -1
			session[:name] = @member.self_information.name
		  session[:member_id] = @member.id
		  redirect_to materials_path
		rescue => e
			render 'new'
	end

	def judge_member
		session[:shopping_cart_id] = -1
		user_id = params[:user_id]
		password = params[:password]
		has_blank, has_em = Member.has_error(user_id, password)
		if has_blank != "" || has_em != ""
			flash[:notice] = has_blank + has_em
			redirect_to action: "error_page"
		elsif Member.judge(user_id) && Member.find_by(user_id: user_id).authenticate(password)
			member = Member.find_by(user_id: user_id)
			session[:name] = member.self_information.name
			session[:member_id] = member.id
			@params = params
			redirect_to materials_path
		else
			@params = params
			flash[:notice] = "パスワードまたはユーザーIDが一致しません"
			redirect_to action: "error_page"
		end
	end

private

	def member_params
		params.require(:member).permit(:user_id, :password, :password_confirmation)	
	end

	def info_params
		params.require(:self_information).permit(:name, :address, :postal, :payment_method, :phone_number)
	end

	def card_params(params)
		card_num = CardInfo.get_card_num(params[:a], params[:b], params[:c], params[:d])
		card_params = { card_num: card_num, deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code] }
	end



end