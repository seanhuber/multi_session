MultiSession.setup do |config|
  # Uncomment to force multi_session cookies to expire after a period of time
  # config.expires = 30.minutes

  # Uncomment to change the domain of the multi_session cookies
  # config.domain = nil

  # Salt used to derive key for GCM encryption. Default value is 'multi session authenticated encrypted cookie'
  # config.authenticated_encrypted_cookie_salt = 'multi session authenticated encrypted cookie'

  # Specify the strategy that your rails application is using for managing credentials.
  config.credentials_strategy = 'credentials'
end
