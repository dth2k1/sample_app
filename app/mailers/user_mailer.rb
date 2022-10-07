class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #

  #1 mail de activre account
  def account_activation(user)
   @user =user
    mail to: user.email, subject:"active account"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #

  #1 gui mail de reset password
  def password_reset
    @user =user
    mail to: user.email, subject:"password reset"
  end
end
