module OmniAuth
  module Strategies
    class Stormpath
      include OmniAuth::Strategy

      option :user_model, nil
      option :login_field, :email_or_username

      def initialize(app, auth_redirect, options = {})
        @auth_redirect = auth_redirect
        super(app, options)
      end

      def request_phase
        Rack::Response.new.tap do |r|
          r.redirect @auth_redirect
          r.finish
        end
      end

      def callback_phase
        begin
          @user = user_model.try(:authenticate, login, password)
        rescue
          return fail!(:invalid_credentials)
        end

        super
      end

      def user_model
        options[:user_model] || ::User
      end

      def login
        request[:sessions][options[:login_field].to_s]
      end

      def password
        request[:sessions]['password']
      end

      uid do
        @user.stormpath_url
      end

    end
  end
end
