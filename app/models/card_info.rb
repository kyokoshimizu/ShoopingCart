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
			card_info
		else
			card_info = CardInfo.new(card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code], order_id: id )
			card_info.save
			card_info
		end
	end

	def self.get_month
		hash = Hash.new
		(1..12).each do |var| hash[var] = var end
		hash
	end

	def self.get_deadline2(num)
		(2015 + num)
	end

	def self.get_times(num)
		times = ["1割", "2回", "12回"]
		times[num-1]
	end

	def self.check_info(self_information_id, order_id)
		card_info = get_card_info(self_information_id, order_id)
		(card_info.card_num == "2929292929292929") && (card_info.code == "292")
	end

	def self.check_deadline(self_information_id, order_id)
		card_info = get_card_info(self_information_id, order_id)
		now_month = (Time.now.strftime("%m")).to_i
    now_year = (Time.now.strftime("%Y")).to_i
    year = (CardInfo.get_deadline2(card_info.deadline2.to_i)).to_i
    month = (card_info.deadline).to_i
    if  year < now_year || (year == now_year && month < now_month)
    	false
    else
    	true
    end
	end

	def self.change_style(msg)
		msg.gsub!("Card num", "カード番号")
		msg.gsub!("Deadline", "有効期限")
		msg.gsub!("Times", "支払い区分")
		msg.gsub!("Code", "セキュリティコード")
	end

	def self.update_id(order, card_info)
		if order.payment_method == 3
			card_info.order_id = order.id
			card_info.save
		end
	end

private
	def self.get_card_info(self_information_id, order_id)
		if self_information_id
			CardInfo.find_by(self_information_id: self_information_id)
		else
			CardInfo.find_by(order_id: order_id)
		end
	end

	def card_params(params, id)
		params ={ card_num: (params[:a] + params[:b] + params[:c] + params[:d]) , deadline: params[:card_info][:deadline], deadline2: params[:card_info][:deadline2], times: params[:card_info][:times], code: params[:card_info][:code], self_information_id: id }
	end
end
