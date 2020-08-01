class UserMailer < ApplicationMailer

  default from: 'Article'
  #
  def password_reset(user_id)
    @user = User.find(user_id)
    @greeting = "Hi"

    mail to: @user.email, Subject: "Password Resset | Article"
  end
end
