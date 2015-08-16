class Account < ActiveRecord::Base
  belongs_to :user
  attr_encrypted :access_token, key: ENV['TOKEN_KEY']

  def self.find_or_create_from_omniauth(omniauth_hash)
    where(provider: omniauth_hash[:provider], uid: omniauth_hash[:uid]).first_or_create do |account|
      account.provider = omniauth_hash[:provider]
      account.uid = omniauth_hash[:uid]
      account.access_token = omniauth_hash[:credentials][:token]
      account.save
    end
  end
end

