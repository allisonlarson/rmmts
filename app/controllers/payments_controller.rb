class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @payments = current_user.payments
  end

  def pay
    @payment = current_user.payments.find(params[:payment_id])
    if @payment.pay
      redirect_to 'index'
    else
      render 'index'
    end
  end
end
