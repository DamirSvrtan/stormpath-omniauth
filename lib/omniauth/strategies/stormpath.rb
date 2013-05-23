module OmniAuth
  module Strategies
    class Stormpath
      include OmniAuth::Strategy

      option :authenticator_method, nil
      option :auth_redirect, nil
      option :login_field, :email_or_username
      option :obtain_uid_method, nil
      option :password_field, :password

      def request_phase
        Rack::Response.new.tap do |r|
          r.redirect options[:auth_redirect]
          r.finish
        end
      end

      def callback_phase
        begin
          @user = options[:authenticator_method].call(login, password)
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
        options[:obtain_uid_method].call(@user)
      end

    end
  end
end
