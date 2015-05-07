class Prow < ActiveRecord::Base
	belongs_to :prescription
	has_one :box_part
	belongs_to :drug
	has_many :consumptions

    # before_save :apply_time_zone
    def self.apply_time_zone
    	# self.due_at = ActiveSupport::TimeZone[time_zone].parse "#{start_time.to_s(:db)} UTC"

	    zone = ActiveSupport::TimeZone.new("Iran")
	    # Time.now.in_time_zone(zone)
	    @prow.start_time = @prow.start_time.in_time_zone(time_zone)
  	end
end
