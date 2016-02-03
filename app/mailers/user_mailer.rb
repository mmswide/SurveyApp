class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end

  def invoice(user, order)
  	@user = user
  	@order = order
  	mail to: user.email, subject: 'Your Purchase invoice'
  end

end
