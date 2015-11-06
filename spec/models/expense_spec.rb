require 'rails_helper'

RSpec.describe Expense do

  it { should belong_to(:user) }
  it { should belong_to(:society) }
  it { should have_many(:payments) }

  describe "#credit_user" do
    let(:society) { Society.create!(name: "Test")}
    let!(:user1) { User.create!(email: "test@example.com", password: "passowrd", society: society)}
    let!(:user2) { User.create!(email: "test1@example.com", password: "passowrd", society: society)}
    let(:expense) { Expense.create!(amount_cents: 100, user: user1, society: society)}
  end

end
