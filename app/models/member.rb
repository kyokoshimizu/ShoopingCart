class Member < ActiveRecord::Base
	has_secure_password
	has_one :self_information
	has_many :browsing_histories
	has_many :orders
	has_many :shopping_carts
	validates_associated :self_information
	validates :password,
		presence: { message: "を入力してください" },
		format: { with: /\A\w{1,8}\z/, allow_blank: true, message: "：半角英数1~8文字で入力してください"}

	def self.judge(user_id)		
		if Member.find_by(user_id: user_id)
			true
		else
			false
		end
	end

	def self.has_error(user_id, password)
		message = ["ユーザーIDとパスワードを入力してください　", "ユーザーIDを入力してください　", "パスワードを入力してください　", "", ""]
		i = 0
		[user_id+password, user_id, password].map do |var|
			break if var == "" || !var
			i += 1
			message[4] = "半角英数字のみです" if i == 1 && /[^ -~｡-ﾟ]/ =~ var
		end
		[message[i], message[4]]
	end

	def self.create_user_id
		user_id = ""
		loop do
			6.times do
				user_id << ascii_codes[rand(0..61)].chr
			end
			break if !(Member.where(user_id: user_id).exists?)
		end
		user_id
	end

private
	def self.ascii_codes
		@ascii_codes ||= create_array
	end

	def self.create_array
			ascii_num = []
			(48..122).each do |i|
				if ( i > 57 && i < 65 ) || ( i > 90 && i < 97 )
					next
				end
				ascii_num << i
			end	
			ascii_num
	end

	def self.find_member(member_id, name)
		if name != ""
			member_id
		end
	end

end