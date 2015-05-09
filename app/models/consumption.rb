class Consumption < ActiveRecord::Base
	belongs_to :prow


	def self.consume(prow_id, time)
    @prow = Prow.find_by_id(prow_id)
    @interval = 30.minutes
    @tik = 0
    if @prow.consumptions != nil
        @prow.consumptions.each do |pc|
      
	        if time.utc - @interval <= pc.created_at and pc.created_at <= time.utc and pc.take_status.to_i == 1
	            @tik = 1 
	            break
	        elsif pc.created_at - @interval <= time.utc and time.utc <= pc.created_at and pc.take_status.to_i == 1
	            @tik = 1 
	            break
	        else
	            @tik = 0
	        end
        end
    else
      @tik = 0
    end
    return @tik
  end


end
