class PaymentMailer < ActionMailer::Base
  default from: 'notifications@rmmts.com'

  def payment_notification_email(payment)
    @user = payment.payer
    @payee = payment.payee
    mail(to: @user.email, subject: "#{@payee.name || @payee.email} has requested a payment")
  end
end
