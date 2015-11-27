class UserMailer < ApplicationMailer
  default from: 'notifications@rottenmangoes.com'

  def deleted_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your account as been deleted.')
  end
end
