class MaterialsController < ApplicationController
	def index
		if params[:category].to_i > 0
			@materials = Category.get_material(params[:category])
		else
			@materials = Material.all
		end
		if session[:name] != ""
			member = Member.find(session[:member_id])
			@info_id = member.self_information.id
		end
	end

	def show
		@material = Material.find_by(id: params[:id])
		if @material
			if session[:name] != ""
				BrowsingHistory.push(@material.id, session[:member_id])
			end
		else
			redirect_to action: 'not_exist'
		end
	end
end