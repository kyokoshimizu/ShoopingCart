class SelfInformation < ActiveRecord::Base
	belongs_to :member
	has_one :card_info
	validates :name, :address, :payment_method, :phone_number, :postal,
		presence: { message: "を入力してください" }
	validates :name,
		length: { maximum: 20, allow_blank: true, message: "：20文字以内の名前にしてください" },
		format: { with: /\A[^\x21-\x2F, \x3a-\x40, \x5b-\x60, \x7b-\x7f, 0-9,"！；：”＃＄＆’（）＝〜｜ー＾￥『』「」＊＋｀＠＿・。、？＞＜１２３４５６７８９"]*\z/, message: "：数字記号は使用できません" }
	validates :address,
		length: { maximum: 30, allow_blank: true, message: "：そんなに長い住所はダメです" }
	validates :postal,
		format: { with: /\A\d{7}\z/, allow_blank: true, message: "：半角数字7桁で記入してください" }
	validates :payment_method,
		numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3, allow_blank: true, message: 'のところで変なことをしないでください' }
	validates :phone_number,
		format: { with: /\A\d{10,13}\z/, allow_blank: true, message: "：半角数字で10〜13文字で記入してください" }

end
