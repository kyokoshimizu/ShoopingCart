class SelfInformation < ActiveRecord::Base
	belongs_to :member
	validates :name, :address, :payment_method, :phone_number,
		presence: true

	def self.has_blank(member_param)
		text = {"name" => "名前", "address" => "住所", "payment_method" => "支払い方法", "phone_number" => "電話番号"}
		member_param.select! { |key, var| var == "" }
		member_param.map { |key, var| text[key] }
	end

end
