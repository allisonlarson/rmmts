require 'rails_helper'

RSpec.describe Expense do
  it { should belong_to(:user) }
  it { should belong_to(:society) }
  it { should have_many(:payments) }
end

