require 'rails_helper'
RSpec.describe User do
  it { should belong_to(:society) }

  context "a valid user" do
    it "has an encrypted access token" do
      user = User.create!(access_token: "12345")

      expect(user.encrypted_access_token).to_not eq(user.access_token)
    end
  end

  context ".find_or_create_from_omniauth" do
    let(:omniauth_hash) { {
      provider: 'venmo',
      uid: '123545',
      credentials: {
        token: 'token'
      },
      info: {
        balance: '0.0'
      },
      extra: {
        raw_info: {
          display_name: 'Test User',
          profile_picture_url: 'img.img'
        }
      }
    }}
    context "a new user" do
      let(:name) { omniauth_hash[:extra][:raw_info][:display_name] }

      it "creates a new user" do
        expect { User.find_or_create_from_omniauth(omniauth_hash) }.to change{ User.count }.by(1)
        user = User.last
        expect(user.name).to eq(name)
      end
    end

    context "an existing user" do
      before { User.create!( name: 'Test', uid: '123545', access_token: '123', image: 'image.com', balance: 0) }

      it "does not create a new user" do
        expect { User.find_or_create_from_omniauth(omniauth_hash) }.to_not change{ User.count }
      end

      it "returns an existing user" do
        original_user = User.last
        omniauth_hash = { uid: original_user.uid }
        found_user = User.find_or_create_from_omniauth(omniauth_hash)
        expect(original_user).to eq(found_user)
      end
    end
  end
end
