require 'multi_session/helper'
require 'multi_session/railtie'
require 'multi_session/session'

module MultiSession
  mattr_accessor :expires
  @@expires = nil

  def self.setup
    yield self
  end
end
