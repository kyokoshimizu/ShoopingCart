class Material < ActiveRecord::Base
	has_one :category
	has_many :cart_details
	has_many :browsing_histories
end
