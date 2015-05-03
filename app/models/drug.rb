class Drug < ActiveRecord::Base
	has_many :prows

	def self.set_drug(drug_name,drug_description)
		if drug_description == nil
			Drug.create(:name => drug_name,:description => nil);
		else
			Drug.create(:name => drug_name,:description => drug_description);
		end
	end
end
