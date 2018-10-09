$:.push File.expand_path('lib', __dir__)

require 'multi_session/version'

Gem::Specification.new do |s|
  s.name        = 'multi_session'
  s.version     = MultiSession::VERSION
  s.authors     = ['Sean Huber']
  s.email       = ['seanhuber@seanhuber.com']
  s.homepage    = 'https://github.com/seanhuber/multi_session'
  s.summary     = 'Creates multiple sessions for Rails'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2.1' # TODO: backport to older versions of rails
end
