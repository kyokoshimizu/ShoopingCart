class CardInfosController < ApplicationController
	def new
		@self_information = SelfInformation.find_by(member_id: session[:member_id])
		@card_info = CardInfo.new
	end

	def edit
		@card_info = CardInfo.find_by(self_information_id: params[:id])
	end
end