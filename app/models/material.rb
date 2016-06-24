class Material < ActiveRecord::Base
	has_one :category
	has_many :cart_details
	has_many :browsing_histories

	def self.more_than_thousant?(price)
		i = 0
		pc = ""
		if price >= 1000
			price.to_s.split("").reverse.map! do |var|
				i += 1
				pc << var
				pc << "," if i < price.to_s.size && i%3 == 0
			end
			pc.reverse
		else
			price
		end
	end

	def self.get_greeting
		time = (Time.now.strftime("%H")).to_i
		if time >= 0 && time < 11
			"おはようございます！"
		elsif  time >= 11 && time < 20
			"こんにちは！"
		else
			"こんばんは！"
		end
	end
end