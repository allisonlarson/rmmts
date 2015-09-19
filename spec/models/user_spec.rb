require 'rails_helper'
RSpec.describe User do
  it { should belong_to(:society) }
  it { should have_many(:expenses) }
  it { should have_many(:accounts).dependent(:destroy) }
  it { should validate_uniqueness_of(:email) }
end
