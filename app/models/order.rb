class Order < ActiveRecord::Base
	belongs_to :shopping_cart
	belongs_to :member
	validates :name, :address, :payment_method, :phone_number,
		presence: true
	
	def self.has_blank(param)
		text = {"name" => "名前", "address" => "住所", "payment_method" => "支払い方法", "phone_number" => "電話番号"}
		param.select! { |key, var| var == "" }
		param.map { |key, var| text[key] }
	end

	def self.get_order(name, id, member_id)
		order = Order.find_by(shopping_cart_id: id)
		if order
			[order, "/orders/#{order.id}/edit"]
		elsif name != ""
			member = Member.find(member_id)
			[Order.new(shopping_cart_id: id, name: member.self_information.name, address: member.self_information.address, payment_method: member.self_information.payment_method, phone_number: member.self_information.phone_number), "/orders/new"]
		else
			[Order.new(shopping_cart_id: id), "/orders/new"]
		end
	end 

	def self.get_method(num)
		method = ["着払い", "銀行振り込み", "カード払い"]
		method[num - 1]
	end

end
