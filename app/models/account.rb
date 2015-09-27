class Account < ActiveRecord::Base
  belongs_to :user
  attr_encrypted :token, key: ENV['TOKEN_KEY']

  def self.find_or_create_from_omniauth(omniauth_hash)
    where(provider: omniauth_hash[:provider], uid: omniauth_hash[:uid]).first_or_create do |account|
      account.provider = omniauth_hash[:provider]
      account.uid = omniauth_hash[:uid]
      account.token = omniauth_hash[:credentials][:token]
      account.save
    end
  end

  def make_payment(uid, payment_amount)
    venmo_url = ENV['VENMO_API'] || "https://sandbox-api.venmo.com/v1"
    payment_amount = payment_amount.format({symbol: false})

    response = HTTP.post("#{venmo_url}/payments", params: {
      access_token: self.token,
      user_id: uid,
      amount: payment_amount,
      note: "Paid roommate using RMMTS.",
      audience: "friends"
    })
    response = JSON.parse(response.body)

    response["data"]["payment"]["status"]
  end
end

