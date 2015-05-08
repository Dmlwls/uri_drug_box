class SendMail < ApplicationMailer
	  default from: "pillbox2015@gmail.com"

  def sample_email(user)
  	@user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
