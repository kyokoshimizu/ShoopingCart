class SelfInformationsController < ApplicationController
	def edit
		@self_information = SelfInformation.find_by(member_id: session[:member_id])
		if @self_information.payment_method == '3'
			@card_info ||= CardInfo.find_or_create_by(self_information_id: @self_information.id)
		end
		redirect_to members_path if !@self_information
	end

	def update
		judge = true
		@self_information = SelfInformation.find_by(member_id: session[:member_id])
		if params["self_information"]["payment_method"] == '3'
			@card_info = CardInfo.re_create(params, @self_information.id)
			judge = @card_info.valid?
		end

		if @self_information.update(info_params) && judge
			@card_info.save if @self_information.payment_method == '3'
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