class MembersController < ApplicationController
	def index
		session[:name] = ""
		session[:shopping_cart_id] = -1
		@id = session[:shopping_cart_id]

	end
	def new
		@member = Member.new
		@member.self_information = SelfInformation.new
	end

	def create
		@member = Member.new(member_params)
		@member.self_information = SelfInformation.new(info_params)
		@card_info = CardInfo.new(card_params)
			Member.transaction do
				@member.save!
				@member.self_information.save!
				@card_info.save!
			end
			@card_info.self_information_id = @member.self_information.id
			@member.user_id = Member.create_user_id
			@member.save
			@card_info.save
			flash[:msg] = "あなたのユーザーIDは、#{@member.user_id} です." 
			session[:name] = @member.self_information.name
		  session[:member_id] = @member.id
		  redirect_to materials_path
		rescue => e
			render 'new'
	end

	def judge_member
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

	def card_params
		params.require(:card_info).permit(:card_num, :deadline, :times, :code)	
	end
end