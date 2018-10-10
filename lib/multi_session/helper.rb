module MultiSession
  module Helper
    extend ActiveSupport::Concern

    included do
      helper_method :multi_session if defined?(helper_method)
      after_action :slide_multi_session
    end

    private

    def multi_session
      Session.new cookies
    end

    def slide_multi_session
      return unless MultiSession.expires.present?
      Session.new(cookies).update_expiration
    end
  end
end
