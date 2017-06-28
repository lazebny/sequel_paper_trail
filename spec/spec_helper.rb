require 'bundler/setup'
require 'sequel'
require 'sqlite3'
require 'pry'

require 'sequel_paper_trail'
require 'sequel/plugins/has_paper_trail'

Dir['./spec/support/*'].each(&method(:require))

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.order = 'random'
  # Enable flags like --only-failures and --next-failure
  # config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
