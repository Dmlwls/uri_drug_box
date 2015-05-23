class Prow < ActiveRecord::Base
	belongs_to :prescription
	has_one :box_part
	belongs_to :drug
	has_many :consumptions

	def self.convert_to_show_period(prow)
        if prow.period_type == "ساعت"
        	@show_period_to_user = prow.period.to_i
      	elsif prow.period_type == "روز"
        	@show_period_to_user = prow.period.to_i / 24
     	elsif prow.period_type == "هفته"
        	@show_period_to_user = prow.period.to_i / (24 * 7)
      	end
      return @show_period_to_user
	end



end
