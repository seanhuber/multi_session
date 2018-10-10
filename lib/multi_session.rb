require 'multi_session/helper'
require 'multi_session/railtie'
require 'multi_session/session'

module MultiSession
  mattr_accessor :authenticated_encrypted_cookie_salt
  @@authenticated_encrypted_cookie_salt = 'multi session authenticated encrypted cookie'

  mattr_accessor :expires
  @@expires = nil

  def self.setup
    yield self
  end
end
