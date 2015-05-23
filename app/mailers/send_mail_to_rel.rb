class SendMailToRel < ApplicationMailer
	 default from: "pillbox1.2015@gmail.com"


	def sample_email_to_rel(curr_user ,user, drug_name, drug_description, time)
		@curr_user = curr_user
	  	@user = user
	  	@drug_name = drug_name
	  	@drug_description = drug_description
	  	@time = time
	  	
	    mail(to: @user.email, subject: 'Smart Pillbox')
  	end

end