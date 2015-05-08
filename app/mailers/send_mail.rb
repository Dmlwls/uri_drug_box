class SendMail < ApplicationMailer
	  default from: "pillbox1.2015@gmail.com"

  def sample_email(user, drug_name, time)
  	@user = user
  	@drug_name = drug_name
  	@time = time
  	
    mail(to: @user.email, subject: 'Sample Email')
  end
end
