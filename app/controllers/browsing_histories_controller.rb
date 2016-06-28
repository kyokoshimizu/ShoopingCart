class BrowsingHistoriesController < ApplicationController
	def index
		if session[:member_id] == ""
			redirect_to members_path
		else
			@browsing_histories = BrowsingHistory.where(member_id: session[:member_id])
		end
	end
end