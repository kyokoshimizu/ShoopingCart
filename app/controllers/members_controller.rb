class MembersController < ApplicationController
	def index
		session[:name] = ""
		session[:shopping_cart_id] = -1
	end

	def new
		@member = Member.new
		@member.self_information = SelfInformation.new
	end

	def create
		@member = Member.new(member_params)
		@member.self_information = SelfInformation.new(info_params)

			Member.transaction do
				@member.save!
				@member.self_information.save!
			end
			@member.user_id = Member.create_user_id
			@member.save
			flash[:msg] = "あなたのユーザーIDは、#{@member.user_id} です." 
			session[:name] = @member.self_information.name
		  session[:member_id] = @member.id
		  redirect_to materials_path
		rescue => e
			@blank = SelfInformation.has_blank(params[:self_information])
			@blank << "パスワード" if !(Member.has_pass?(params[:member])) 
			flash[:notice] = @blank.to_s + "ちゃんと入力してください"
			render 'new'
	end

	def judge_member
		user_id = params[:user_id]
		password = params[:password]
		if Member.judge(user_id) && Member.find_by(user_id: user_id).authenticate(password)
			member = Member.find_by(user_id: user_id)
			session[:name] = member.self_information.name
			session[:member_id] = member.id
			redirect_to materials_path
		else
			redirect_to action: "error_page"
		end
	end

private

	def member_params
		params.require(:member).permit(:user_id, :password, :password_confirmation)	
	end

	def info_params
		params.require(:self_information).permit(:name, :address, :payment_method, :phone_number)
	end

end