$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "omniauth-stormpath/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omniauth-stormpath"
  s.version     = OmniauthStormpath::VERSION
  s.authors     = ["Boram Yoon", "Erin Swenson-Healey"]
  s.email       = ["boram@carbonfive.com", "erin@carbonfive.com"]
  s.homepage    = "https://github.com/laser/omniauth-stormpath"
  s.summary     = "An OmniAuth strategy for use with Stormpath"
  s.description = "An OmniAuth strategy for use with Stormpath"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.1"
  s.add_runtime_dependency "omniauth", "~> 1.0"
  s.add_runtime_dependency "bcrypt-ruby", "~> 3.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara", "~> 1.1.2"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-debugger"
end
