module MultiSession
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    desc 'creates a config/initializers/multi_session.rb file for configuring multi_session'
    def install
      template 'multi_session.rb', 'config/initializers/multi_session.rb'
    end
  end
end
