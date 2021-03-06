OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stormpath, :setup => lambda { |env|
    env['omniauth.strategy'].options[:stormpath_application] = ::Stormpath::Rails::Client.root_application
  }
end
