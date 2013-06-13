require 'stormpath-sdk'

module OmniAuth
  module Strategies
    class Stormpath
      include OmniAuth::Strategy

      option :login_field, :email_or_username
      option :password_field, :password
      option :stormpath_application, nil

      def callback_phase
        raise 'missing stormpath_application' unless options[:stormpath_application]

        begin
          login_request = ::Stormpath::Authentication::UsernamePasswordRequest.new(login, password)
          auth_result = options[:stormpath_application].authenticate_account(login_request)
          @account = auth_result.account
        rescue
          return fail!(:invalid_credentials)
        end

        super
      end

      def login
        request[options[:login_field].to_s]
      end

      def password
        request[options[:password_field].to_s]
      end

      uid do
        @account.href
      end

    end
  end
end
