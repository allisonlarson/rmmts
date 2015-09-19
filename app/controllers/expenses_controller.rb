class ExpensesController < ApplicationController

  def index
    @expense = current_society.expenses.new
    @expenses = current_society.expenses
  end

  def create
    @expense = current_society.expenses.new(expenses_params)
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
