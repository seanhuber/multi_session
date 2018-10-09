module MultiSession
  module Helper
    extend ActiveSupport::Concern

    included do
      helper_method :multi_session if defined?(helper_method)
    end

    private

    def multi_session
      Session.new cookies
    end
  end
end
