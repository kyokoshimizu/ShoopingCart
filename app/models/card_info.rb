class CardInfo < ActiveRecord::Base
	belongs_to :self_information
	belongs_to :order
	validates :card_num,
		presence: { message: "を入力してください" },
		format: { with: /\A\d{16}\z/, allow_blank: true, message: "：半角数字4桁づつで記入してください" }
	validates :deadline, :deadline2, :times,
		presence: { message: "を入力してください" }
	validates :code,
		presence: { message: "を入力してください" },
		format: { with: /\A\d{3,4}\z/, allow_blank: true, message: "：半角数字3~4桁づつで記入してください"}


	def self.create(params, id)
		card_info = CardInfo.new(card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code], self_information_id: id )
	end

	def self.create_order(params, id)
		card_info = CardInfo.new(card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code], order_id: id )
	end


	def self.re_create(params, id)
		if CardInfo.find_by(self_information_id: id)
			card_info = CardInfo.find_by(self_information_id: id)
			card_info.update(card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code], self_information_id: id )
		else
			card_info = CardInfo.new(card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code], self_information_id: id )
			card_info.save
		end
	end

	def self.re_create_order(params, id)
		if CardInfo.find_by(order_id: id)
			card_info = CardInfo.find_by(order_id: id)
			card_info.update(card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code], order_id: id )
		else
			card_info = CardInfo.new(card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code], order_id: id )
			card_info.save
		end
	end

	def self.get_month
		{ '1月' => 1, '2月' => 2, '3月' => 3, '4月' => 4, '5月' => 5, '6月' => 6, '7月' => 7, '8月' => 8, '9月' => 9, '10月' => 10, '11月' => 11, '12月' => 12 }
	end

private
	def card_params(params, id)
		params ={card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], times: params[:card_info][:times], code: params[:card_info][:code], self_information_id: id }
	end
end
