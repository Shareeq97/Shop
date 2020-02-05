class CommentNotifierMailer < ApplicationMailer
	default from: 'shop@assignmentProject.com'
 
  def notify_mail(recipient, comment)
    @recipient = recipient
    @comment = comment
    @url  = 'http://localhost:3000/login'
    mail(
      to: @recipient.email,
      subject: 'Got A Comment')
  end
end
