class Drug < ActiveRecord::Base
	has_many :prows

	def self.add_drug(drug_name,drug_description)
		if drug_description == nil
			Drug.create(:name => drug_name,:description => nil);
		else
			Drug.create(:name => drug_name,:description => drug_description);
		end
	end
	def self.set_drug(drug_id,drug_name,drug_description)
		@drug =  Drug.find_by_id(drug_id)
		if drug_description == nil
			@drug.update(:name => drug_name,:description => nil);
		else
			@drug.update(:name => drug_name,:description => drug_description);
		end
	end
end
