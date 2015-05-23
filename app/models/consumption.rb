class Consumption < ActiveRecord::Base
	belongs_to :prow

	#######################################use in is_near##############################33
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


def self.consumption_table(current_user)

    @prow_arr = Array.new
    @all_times = Array.new
    @separator = 0
    @temp_separator = 0

    current_user.prescriptions.each do |upres|
      upres.prows.each do |uprow|
        @prow_arr[@prow_arr.size] = uprow
      end
    end

    @prow_arr.each do |pp|
      @all_times[@separator] = [pp.start_time, pp.id, 0, 0]
      
      for i in 1..pp.qty-1 do
        @all_times[@separator+i] = [(@all_times[@separator+i-1][0] + pp.period.to_i.hours), pp.id, 0, 0]
          @temp_separator = i
      end
 
      @separator +=  @temp_separator 
      @separator += 1

    end

    @all_times = @all_times.sort

    return @all_times
end




def self.consumption_for_noti(current_user, prow_id)

    @prow_arr = Array.new
    @all_times = Array.new
    @separator = 0;

    @curr_prow = Prow.find_by_id(prow_id)

    @all_times[0] = [@curr_prow.start_time, @curr_prow.id, 0, 0]
      
    for i in 1..@curr_prow.consumed_qty-1 do
      @all_times[@separator+i] = [(@all_times[@separator+i-1][0] + @curr_prow.period.to_i.hours), @curr_prow.id, 0, 0]
    end

    @all_times = @all_times.sort

    return @all_times
end



def self.consume_vi(i,prow_id, time)
    @prow = Prow.find_by_id(prow_id)
    @interval = 30.minutes
    @tik = 0
    if @prow.consumptions != nil
        @prow.consumptions.each do |pc|
          if time.utc - @interval <= pc.created_at and pc.created_at <= time.utc and pc.take_status.to_i == 1
            @tik = 1 
            @all_times[i][2] = 1
            break
         
          elsif pc.created_at - @interval <= time.utc and time.utc <= pc.created_at and pc.take_status.to_i == 1
            @tik = 1 
            @all_times[i][2] = 1
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


def self.find_drug(prid)
    @prow = Prow.find_by_id(prid)
    @drug = Drug.find_by_id(@prow.drug_id)
    return @drug
end


def self.if_noti(current_user, prow_id)
    @all_times = Consumption.consumption_for_noti(current_user,prow_id)
    
    @sth = Delayed::Job.enqueue(ConsumptionJob.new(@all_times[0][1],@all_times[0][0],current_user),0, (((@all_times[0][0]-Time.now.utc)/60).to_i+20).minutes.from_now)

    for i in 1..@all_times.size-1
      Delayed::Job.enqueue(ConsumptionJob.new(@all_times[i][1],@all_times[i][0],current_user),0, (((@all_times[i][0]-Time.now.utc)/60).to_i+20).minutes.from_now)
    end

    return @sth
end

end