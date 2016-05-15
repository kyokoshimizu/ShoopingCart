class SelfInformationsController < ApplicationController
	def edit
		@self_information = SelfInformation.find_by(member_id: session[:member_id])
	end

	def update
		@self_information = SelfInformation.find_by(member_id: session[:member_id])
		if @self_information.update(info_params)
			session[:name] = info_params[:name]
			redirect_to materials_path
		else
			flash[:notice] = "すべてちゃんと入力してください"
			render 'edit'
		end
	end

private
	def info_params
		params.require(:self_information).permit(:name, :address, :payment_method, :phone_number)
	end
end