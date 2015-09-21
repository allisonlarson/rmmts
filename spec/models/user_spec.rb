require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:society) }
  it { should have_many(:expenses) }
  it { should have_many(:accounts).dependent(:destroy) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:payments).with_foreign_key(:payer_id) }
  it { should have_many(:collections).class_name('Payment').with_foreign_key(:payee_id) }
end
