module MultiSession
  class Railtie < ::Rails::Railtie
    initializer 'multi_session.configure_rails_initialization' do |app|
      ActionController::Base.send :include, MultiSession::Helper
    end
  end
end
