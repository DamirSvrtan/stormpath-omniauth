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
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stormpath, :setup => lambda { |env|
    env['omniauth.strategy'].options[:auth_redirect] = '/session/new'
    env['omniauth.strategy'].options[:authenticator_class] = ::User
    env['omniauth.strategy'].options[:obtain_uid] = Proc.new { |o| o.stormpath_url }
  }
end
```

Without Rack:

```ruby
OmniAuth::Strategies::Developer.new(some_app, {
  :auth_redirect => '/login',
  :authentication_class => ::Authenticator,
  :obtain_uid => Proc.new { |o| o.href }
})
```

A quick explanation of the three required options:

### auth_redirect

Where to redirect the browser in order to display a form that will collect
login information.

### authenticator_class

A class who will implement a method "authenticate" and return an object
representation (or superset) of a Stormpath Account. If you're using
stormpath-rails, this will be the class that's included the
Stormpath::Rails::Account module (::User, in this project's sample app).

### obtain_uid

A method invoked on the object returned from the "authenticate" method which
returns a value that OmniAuth uses to uniquely identify a user in your system.
If you're using stormpath-rails, this will look something like:

```ruby
obtain_uid = Proc.new { |obj| obj.stormpath_url }
```

If your application is not storing any Stormpath data in a local database and
your authenticate method returned an instance of Stormpath::Resource::Account,
then this method could look like:

```ruby
obtain_uid = Proc.new { |account| account.href }
```
