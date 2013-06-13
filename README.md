# Stormpath OmniAuth Strategy

Stormpath is the first easy, secure user management and authentication service
for developers. This is an OmniAuth strategy that will integrate with Stormpath.

## Quickstart Guide

1. From the root of the repo, navigate to the dummy directory and execute the
   following Rake tasks:

   ```sh
   cd spec/dummy
   rake db:migrate
   rake db:test:prepare
   ```

1. You should then be able to run the full suite of specs from the root of the
   repo, like so:

   ```sh
   rake spec
   ```

## Required Configuration Options

In order to use the Stormpath OmniAuth Strategy, three configuration options
must be specified. These options can be passed in a hash (second parameter of
the Strategy constructor), or (more commonly) set up by Rack during the "setup"
phase.

With Rack:

```ruby
# if using 'stormpath-rails'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stormpath, :setup => lambda { |env|
    env['omniauth.strategy'].options[:stormpath_application] = ::Stormpath::Rails::Client.root_application
  }
end

# if using without 'stormpath-rails' - perhaps with the SDK and Sinatra

use OmniAuth::Builder do
  provider :stormpath, setup: -> env {
    env['omniauth.strategy'].options[:stormpath_application] = ::MySinatraApp.get_application
  }
end

```

The Stormpath OmniAuth strategy requires only that you pass (as an option) a
reference to an instance of Stormpath::Resource::Application that the strategy
will use to authenticate login attempts.
