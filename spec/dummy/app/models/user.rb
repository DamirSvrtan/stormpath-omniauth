require 'stormpath-rails'

class User < ActiveRecord::Base
  include Stormpath::Rails::Account

  def self.from_omniauth(auth)
    where(stormpath_url: auth["uid"]).first
  end
end

