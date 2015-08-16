require 'rails_helper'

RSpec.describe Society do

  it { should have_many(:users) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end
