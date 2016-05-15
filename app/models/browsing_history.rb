class BrowsingHistory < ActiveRecord::Base
	belongs_to :member
	belongs_to :material
	def self.push(material_id, member_id)
		if BrowsingHistory.where(member_id: member_id).count >= 10
			BrowsingHistory.where(member_id: member_id).first.destroy
		end
		member = Member.find(member_id)
		browsing_history = member.browsing_histories.build(material_id: material_id, day: DateTime.now)
		browsing_history.save
	end

end
