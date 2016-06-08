class CartDetail < ActiveRecord::Base
	belongs_to :shopping_cart
	belongs_to :material
	validates :num,
		presence: { on: :update, message: "を入力してください"},
		numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 99, message: "半角数字で99個までしか選択できません" }

	def self.add(shopping_cart_id, material_id)
			cart_detail = CartDetail.find_by(shopping_cart_id: shopping_cart_id, material_id: material_id)
 		if !cart_detail
			cart_detail = CartDetail.new(shopping_cart_id: shopping_cart_id, material_id: material_id, num: 1)
		else
			cart_detail.num += 1
		end
		cart_detail.save
		cart_detail
	end

	def self.has_error?(cart_detail)
		error_message = ""
		if cart_detail.errors.any?
			cart_detail.errors.full_messages.each do |msg|
				msg = "・削除ボタンを押してください\n" if cart_detail.num == 0 
				error_message += msg
			end
		end
		error_message
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
