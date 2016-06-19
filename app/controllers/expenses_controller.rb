class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @expense = current_society.expenses.new
    @expenses = Expense.where(society: current_society)
  end

  def create
    @expense = current_society.expenses.new(expenses_params.merge!(user_id: current_user.id))
    Builders::Expense.new(@expense).build_payments_from_expense

    if @expense.save
      redirect_to society_expenses_path(current_society)
    else
      render 'index'
    end
  end

  private

  def expenses_params
    params.require(:expense).permit!
  end

end
