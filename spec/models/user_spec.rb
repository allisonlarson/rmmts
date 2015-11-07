require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:society) }
  it { should have_many(:expenses) }
  it { should have_many(:accounts).dependent(:destroy) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:payments).with_foreign_key(:payer_id) }
  it { should have_many(:collections).class_name('Payment').with_foreign_key(:payee_id) }

  describe "#full_credit?" do
    let(:user) { User.create!(email: "test@example.com", password: "password", credit_cents: 100) }

    context "with full credit" do
      it "returns true" do
        expect(user.full_credit?(Money.new(100))).to eq(true)
      end
    end

    context "without full credit" do
      it "returns false" do
        expect(user.full_credit?(Money.new(200))).to eq(false)
      end
    end
  end
end
