class CartDetail < ActiveRecord::Base
	belongs_to :shopping_cart
	belongs_to :material

	def self.add(shopping_cart_id, material_id)
			cart_detail = CartDetail.find_by(shopping_cart_id: shopping_cart_id, material_id: material_id)
 		if !cart_detail
			cart_detail = CartDetail.new(shopping_cart_id: shopping_cart_id, material_id: material_id, num: 1)
		else
			cart_detail.num += 1
		end
		cart_detail.save
	end

	def self.get_price(cart_detail, shopping_cart_id)
		cart_details = CartDetail.where(shopping_cart_id: shopping_cart_id)
		sum = 0
		cart_details.each do |c|
			sum += (c.material.price.to_i * c.num.to_i)
		end
		sum - (cart_detail.num * cart_detail.material.price)
	end
end
