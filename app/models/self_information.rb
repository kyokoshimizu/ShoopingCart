class SelfInformation < ActiveRecord::Base
	belongs_to :member
	has_one :card_info
	validates :name,
		presence: { message: "を入力してください" },
		length: { maximum: 20, allow_blank: true, message: "：20文字以内の名前にしてください" },
		format: { with: /\A[^\x21-\x2F, \x3a-\x40, \x5b-\x60, \x7b-\x7f, 0-9,"！；：”＃＄＆’（）＝〜｜ー＾￥『』「」＊＋｀＠＿・。、？＞＜１２３４５６７８９"]*\z/, message: "：数字記号は使用できません" }
	validates :postal,
		presence: { message: "を入力してください" },
		format: { with: /\A\d{7}\z/, allow_blank: true, message: "：半角数字7桁で記入してください" }
	validates :address,
		presence: { message: "を入力してください" },
		length: { maximum: 30, allow_blank: true, message: "：そんなに長い住所はダメです" }
	validates :phone_number,
		presence: { message: "を入力してください" },
		format: { with: /\A\d{10,13}\z/, allow_blank: true, message: "：半角数字で10〜13文字で記入してください" }
	validates :payment_method,
		presence: { message: "を入力してください" },
		numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3, allow_blank: true, message: 'のところで変なことをしないでください' }
end
