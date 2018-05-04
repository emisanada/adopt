require 'support/factory_bot'
require 'simplecov'
require 'fuubar'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  require File.expand_path("../../config/environment", __FILE__)
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.fuubar_progress_bar_options = { format: 'Progress: [%c/%C] |%B| %p%% %a', progress_mark: '█' }
end

SimpleCov.minimum_coverage 90
