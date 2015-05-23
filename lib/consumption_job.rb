
require 'net/http'
class ConsumptionJob < Struct.new(:prid, :time, :current_user)
	def perform
		@tik = Consumption.consume(prid, time)
		if @tik == 0
			@prow = Prow.find_by_id(prid)

			current_user.notifications.each do |noti|
				
				if noti.noti_type == false
					
					if noti.destination == "خودتان"
						SendMail.sample_email(current_user, Consumption.find_drug(prid).name, Consumption.find_drug(prid).description, time ).deliver	
					else
						@rel = Relative.find_by_id(noti.destination)
						SendMailToRel.sample_email_to_rel(current_user, @rel,  Consumption.find_drug(prid).name, Consumption.find_drug(prid).description, time ).deliver
					end

					
				elsif noti.noti_type == true
				
					if noti.destination == "خودتان"
						@to = current_user.profile.phone_number
						@drug_name = @prow.drug.name
						@text = 'you+dont+consume+'
						url = URI.parse('http://www.sibsms.com/APISend.aspx?Username=09123134254&Password=532746&From=50002060399333&To='+@to+'&Text='+@text).force_encoding("utf-8")
	  					req = Net::HTTP::Get.new(url.to_s)
  					else
  						@rel = Relative.find_by_id(noti.destination)
  						@to = @rel.phone_number
						@drug_name = @prow.drug.name
						@text = 'he/she+doesnt+consume+'
						url_str = ('http://www.sibsms.com/APISend.aspx?Username=09123134254&Password=532746&From=50002060399333&To='+@to+'&Text='+@text).force_encoding("utf-8")
						url = URI.parse(url_str)
	  					req = Net::HTTP::Get.new(url.to_s)
  					end
  					
				end

			end
			
		end
	end
end