require 'vcr'
require 'webmock'
require 'pry'
require 'pry-debugger'

ENV["RAILS_ENV"] ||= 'test'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

require File.expand_path("../dummy/config/environment", __FILE__)

require 'rspec/rails'
