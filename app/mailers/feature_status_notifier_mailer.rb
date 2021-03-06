class FeatureStatusNotifierMailer < ApplicationMailer
	default from: 'shop@assignmentProject.com'

  def notify_mail(recipient, feature)
  	@recipient = recipient
  	@feature = feature
    @url  = 'http://localhost:3000/login'
    mail(
    	to: @recipient.email,
   		subject: "Project's Feature Status Changed")
  end

end
