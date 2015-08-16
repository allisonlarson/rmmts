require 'rails_helper'
RSpec.describe Account do
  context "a valid account" do
    it "has an encrypted access token" do
      account = Account.create!(access_token: "12345")

      expect(account.encrypted_access_token).to_not eq(account.access_token)
    end
  end

  context ".find_or_create_from_omniauth" do
    let(:omniauth_hash) { {
      provider: 'venmo',
      uid: '123545',
      credentials: {
        token: 'token'
      },
    }}
    context "a new user" do
      let(:uid) { omniauth_hash[:uid] }

      it "creates a new user" do
        expect { Account.find_or_create_from_omniauth(omniauth_hash) }.to change{ Account.count }.by(1)
        account = Account.last
        expect(account.uid).to eq(uid)
      end
    end

    context "an existing user" do
      before { Account.create!( provider: 'venmo', uid: '123545', access_token: 'token') }

      it "does not create a new user" do
        expect { Account.find_or_create_from_omniauth(omniauth_hash) }.to_not change{ Account.count }
      end

      it "returns an existing user" do
        original_account = Account.last
        omniauth_hash = { provider: original_account.provider, uid: original_account.uid }
        found_account = Account.find_or_create_from_omniauth(omniauth_hash)
        expect(original_account).to eq(found_account)
      end
    end
  end
end
