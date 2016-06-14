class CardInfo < ActiveRecord::Base
	belongs_to :self_information
	belongs_to :order
end
