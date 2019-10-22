class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("send-mail-signup.tittle-send-mail9")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("send-mail-signup.tittle-send-mail10")
  end
end
