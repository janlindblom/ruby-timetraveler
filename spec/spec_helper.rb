require "simplecov"
require 'simplecov-cobertura'

SimpleCov.minimum_coverage 50
SimpleCov.minimum_coverage_by_file 30

SimpleCov.start do
  add_filter 'vendor'
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::CoberturaFormatter,
    SimpleCov::Formatter::HTMLFormatter
  ])
end

require "bundler/setup"
require "time_traveler"
require "time_traveler/utils"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
