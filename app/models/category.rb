class Category < ActiveRecord::Base
	belongs_to :material
	CATEGORY = ["全て", "家具", "余暇"]

	def self.get_category(category_num)
		CATEGORY[category_num.to_i]
	end

	def self.get_material(num)
		material = []
		Category.where(category: num).each do |var|
			material << Material.find_by(id: var.material_id)
		end
		material
	end
end