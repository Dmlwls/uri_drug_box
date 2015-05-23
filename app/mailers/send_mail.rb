class SendMail < ApplicationMailer
	  default from: "pillbox1.2015@gmail.com"

    def sample_email(user, drug_name, drug_description, time)
	  	@user = user
	  	@drug_name = drug_name
	  	@drug_description = drug_description
	  	@time = time
	  	
	    mail(to: @user.email, subject: 'Smart Pillbox')
    end


end
