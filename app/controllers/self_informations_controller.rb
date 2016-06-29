class SelfInformationsController < ApplicationController
	def edit
		@self_information = SelfInformation.find_by(member_id: session[:member_id])
		redirect_to members_path if !@self_information
	end

	def update
		@self_information = SelfInformation.find_by(member_id: session[:member_id])
		if @self_information.update(info_params)
		p	CardInfo.re_create(params, @self_information.id) if @self_information.payment_method == '3'
			session[:name] = info_params[:name]
			redirect_to materials_path
		else
			render 'edit'
		end
	end

private
	def info_params
		params.require(:self_information).permit(:name, :address, :postal, :payment_method, :phone_number)
	end

	def card_params
		params.require(:card_info).permit(:card_num, :deadline, :times, :code)
	end
end