require 'rails_helper'

RSpec.describe Credit do
  it { should belong_to(:owner) }
  it { should belong_to(:user) }
end
