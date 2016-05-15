class BrowsingHistoriesController < ApplicationController
	def index
		@browsing_histories = BrowsingHistory.where(member_id: session[:member_id])
	end
end