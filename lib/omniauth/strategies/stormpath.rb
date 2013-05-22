module OmniAuth
  module Strategies
    class Stormpath
      include OmniAuth::Strategy

      option :authenticator_class, nil
      option :auth_redirect, nil
      option :login_field, :email_or_username
      option :password_field, :password
      option :obtain_uid, nil

      def request_phase
        Rack::Response.new.tap do |r|
          r.redirect options[:auth_redirect]
          r.finish
        end
      end

      def callback_phase
        begin
          @user = options[:authenticator_class].authenticate(login, password)
        rescue
          return fail!(:invalid_credentials)
        end

        super
      end

      def login
        request[:sessions][options[:login_field].to_s]
      end

      def password
        request[:sessions][options[:password_field].to_s]
      end

      uid do
        options[:obtain_uid].call(@user)
      end

    end
  end
end
