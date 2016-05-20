class PhotosController < ApplicationController
	def photo
		@material_photo = Photo.find_by(material_id: params[:id])
		send_data @material_photo.photo
	end
end