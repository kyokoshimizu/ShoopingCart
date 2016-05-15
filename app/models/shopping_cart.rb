class ShoppingCart < ActiveRecord::Base
	has_many :cart_details
	has_one :order
	belongs_to :member

	def self.selected_matelials(cart_id)
		cart_details = CartDetail.where(shopping_cart_id: cart_id)
		cart_details.map { |d| Material.find(d.material_id) }
	end

	def self.create_cart(name, member_id)
		if name == ""
			shopping_cart = ShoppingCart.new
			shopping_cart.save
		else
			member = Member.find(member_id)
			shopping_cart = member.shopping_carts.build
			member.save
		end
		shopping_cart.id
	end
end
