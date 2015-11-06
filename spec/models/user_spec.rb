require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:society) }
  it { should have_many(:expenses) }
  it { should have_many(:accounts).dependent(:destroy) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:payments).with_foreign_key(:payer_id) }
  it { should have_many(:collections).class_name('Payment').with_foreign_key(:payee_id) }
  it { should have_many(:credits).with_foreign_key(:owner_id) }

  describe "#credit!" do
    let(:user) { User.create(email: "test@example.com", password: "password")}
    let(:other) { User.create(email: "other@example.com", password: "password")}

    context "without existing credit" do
      it "creates a new credit between users" do
        expect{ user.credit!(100, other) }.to change{ Credit.count }.by(1)
        expect(user.credits.find_by(user_id: other.id).amount).to eq(100)
      end
    end

    context "with existing credit" do
      let!(:credit) { Credit.create(owner_id: user.id, user_id: other.id, amount: 50)}

      it "applies new amount to credit" do
        expect{ user.credit!(25, other) }.to_not change{ Credit.count }
        expect(user.credits.find_by(user_id: other.id).amount).to eq(75)
      end
    end
  end

  describe "#total_owed" do
    let(:user) { User.create(email: "test@example.com", password: "password")}

    before do
      Credit.create!(owner_id: user.id, amount: 50)
      Credit.create!(owner_id: user.id, amount: 50)
    end

    it "sums all credits" do
      expect(user.total_owed).to eq(100)
    end
  end

  describe "#make_payment" do

  end
end
