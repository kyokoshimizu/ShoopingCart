class Order < ActiveRecord::Base
	belongs_to :shopping_cart
	belongs_to :member
	has_one :card_info
	validates :name,
		presence: { message: "を入力してください" },
		length: { maximum: 20, allow_blank: true, message: "：20文字以内の名前にしてください" },
		format: { with: /\A[^\x21-\x2F, \x3a-\x40, \x5b-\x60, \x7b-\x7f, 0-9]*\z/, message: "：数字記号は使用できません" }
	validates :postal,
		presence: { message: "を入力してください" },
		format: { with: /\A\d{7}\z/, allow_blank: true, message: "：半角数字7桁で記入してください" }
	validates :address,
		presence: { message: "を入力してください" },
		length: { maximum: 30, allow_blank: true, message: "：そんなに長い住所はダメです" }
	validates :payment_method,
		presence: { message: "を入力してください" },
		numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3, allow_blank: true, message: 'のところで変なことをしないでください' }
	validates :phone_number,
		presence: { message: "を入力してください" },
		format: { with: /\A\d{10,13}\z/, allow_blank: true, message: "：半角数字で10〜13文字で記入してください" }
	
	def self.get_order(name, id, member_id)
		order = Order.find_by(shopping_cart_id: id)
		if order
			[order, "/orders/#{order.id}/edit"]
		elsif name != ""
			member = Member.find(member_id)
			[Order.new(shopping_cart_id: id, member_id: member_id, name: member.self_information.name, address: member.self_information.address, payment_method: member.self_information.payment_method, phone_number: member.self_information.phone_number), "/orders/new"]
		else
			[Order.new(shopping_cart_id: id), "/orders/new"]
		end
	end

	def self.check_member(order, member_id)
		if order.member_id == member_id
			true
		else
			false
		end
	end

	def self.get_method(num)
		method = ["代金引換", "銀行振り込み", "カード払い"]
		method[num - 1]
	end

end
