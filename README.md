# Stormpath OmniAuth Strategy

Stormpath is the first easy, secure user management and authentication service
for developers. This is an OmniAuth strategy that will integrate with Stormpath.

## Setup

### <a name="signup"></a>Sign Up For A Stormpath Account

1. Create a [Stormpath][stormpath] developer account and [create your API Keys][create-api-keys]
  downloading the "apiKey.properties" file into a ".stormpath"
  folder under your local home directory. So that the Rails gem knows where to find this file,
  add an environment variable called `STORMPATH_API_KEY_FILE_LOCATION` whose value is the full
  path to this new .properties file:

    ```
    export STORMPATH_API_KEY_FILE_LOCATION="/Users/john/.stormpath/apiKey.properties"
    ```

2. Within Stormpath's Admin Console, create an application  and a directory to store your users' accounts through the [Stormpath Admin][stormpath-admin] interface. Make sure to add the newly-created directory as a Account Store for your newly-created application.

3. Through the [Stormpath Admin][stormpath-admin] interface, note your application's REST URL. You'll want to create an environment variable called "STORMPATH\_APPLICATION\_URL" whose value is this URL. For example, add into your ~/.bashrc file on OS X:

    ```
    export STORMPATH_APPLICATION_URL="https://api.stormpath.com/v1/applications/YOUR_APP_ID"
    ```

### Install and Configure The Stormpath Omniauth Gem

1. Clone the [Stormpath-Omniauth](https://github.com/stormpath/stormpath-omniauth) repository to your local

2. From the root of the repo, navigate to the dummy directory and execute the
   following Rake tasks to install the stormpath-omniauth gem:

   ```sh
   cd spec/dummy
   gem install bundler
   bundle install
   rake db:migrate
   rake db:test:prepare
   ```

<!--
1. You should then be able to run the full suite of specs from the root of the
   repo using the following commands:

   ```sh
   cd ../../
   rake spec
   ```
-->

## Usage

To use this integration with Rails, include the following initializer in your Rails application:

```ruby
# if using 'stormpath-rails'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stormpath, setup: -> env {
    env['omniauth.strategy'].options[:stormpath_application] = ::Stormpath::Rails::Client.application
  }
end
```

For an example to follow, refer to the [Rails sample app][rails-omniauth-sample].

To use this integration with Sinatra, include the following in your Sinatra application:

```ruby
use OmniAuth::Builder do
  provider :stormpath, setup: -> env {
    env['omniauth.strategy'].options[:stormpath_application] = ::MySinatraApp.get_application
  }
end

```

For an example to follow, refer to the [Sinatra sample app][sinatra-omniauth-sample].

The Stormpath OmniAuth strategy requires only that you pass (as an option) a
reference to an instance of Stormpath::Resource::Application that the strategy
will use to authenticate login attempts.

  [sinatra-omniauth-sample]: https://github.com/stormpath/stormpath-ruby-samples/tree/master/sinatra-omniauth
  [rails-omniauth-sample]: https://github.com/stormpath/stormpath-ruby-samples/tree/master/rails-omniauth
