require 'rails_helper'
RSpec.describe Payment do
  it { should belong_to(:payee) }
  it { should belong_to(:payer) }
  it { should belong_to(:expense) }
end
