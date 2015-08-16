require 'rails_helper'

RSpec.describe Society do
  it { should have_many(:users) }
end
