class User < ActiveRecord::Base
  attr_encrypted :access_token, key: ENV['TOKEN_KEY']
  belongs_to :society

  def self.find_or_create_from_omniauth(omniauth_hash)
    where(uid: omniauth_hash[:uid]).first_or_create do |user|
      user.name = omniauth_hash[:extra][:raw_info][:display_name]
      user.uid = omniauth_hash[:uid]
      user.access_token = omniauth_hash[:credentials][:token]
      user.image = omniauth_hash[:extra][:raw_info][:profile_picture_url]
      user.balance = omniauth_hash[:info][:balance].to_i
      user.save
    end
  end
end
