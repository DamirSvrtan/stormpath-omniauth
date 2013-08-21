
# Stormpath OmniAuth Strategy

Stormpath is the first easy, secure user management and authentication service
for developers. This is an OmniAuth strategy that will integrate with Stormpath.

## Quickstart Guide

1. From the root of the repo, navigate to the dummy directory and execute the
   following Rake tasks:

   ```sh
   cd spec/dummy
   gem install bundler
   bundle install
   rake db:migrate
   rake db:test:prepare
   ```

1. You should then be able to run the full suite of specs from the root of the
   repo using the following commands:

   ```sh
   cd ../../
   rake spec
   ```

## Usage

To use this with Rails, include the following initializer:

```ruby
# if using 'stormpath-rails'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stormpath, setup: -> env {
    env['omniauth.strategy'].options[:stormpath_application] = ::Stormpath::Rails::Client.application
  }
end
```

Check out this [Rails sample app][rails-omniauth-sample].

To use this with Sinatra, include the following:

```ruby
use OmniAuth::Builder do
  provider :stormpath, setup: -> env {
    env['omniauth.strategy'].options[:stormpath_application] = ::MySinatraApp.get_application
  }
end

```

Check out this [Sinatra sample app][sinatra-omniauth-sample].

The Stormpath OmniAuth strategy requires only that you pass (as an option) a
reference to an instance of Stormpath::Resource::Application that the strategy
will use to authenticate login attempts.

  [sinatra-omniauth-sample]: https://github.com/stormpath/stormpath-ruby-samples/tree/master/sinatra-omniauth
  [rails-omniauth-sample]: https://github.com/stormpath/stormpath-ruby-samples/tree/master/rails-omniauth
