Rails.application.config.middleware.use OmniAuth::Builder do
  provider :venmo, ENV['VENMO_CLIENT_ID'], ENV['VENMON_CLIENT_SECRET'], scope: ['access_balance, access_profile, make_payments']
end
