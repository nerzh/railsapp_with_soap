# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'shoulda/matchers'

include Warden::Test::Helpers

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
# ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_framework = :rspec
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    # mocks.verify_partial_doubles = true
    # mocks.verify_doubled_constant_names = true
  end

  config.around(:each, type: :view) do |ex|
    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = false
      ex.run
      mocks.verify_partial_doubles = true
    end
  end
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.verbose_retry = true
  config.default_retry_count = ENV['CIRCLECI'] ? 3 : 1
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = false

  config.infer_base_class_for_anonymous_controllers = false
  config.expose_current_running_example_as :example

  config.infer_spec_type_from_file_location!

  config.order = 'random'

  # config.before(:suite) do
  #   DatabaseCleaner.clean_with(:truncation)
  # end

  # config.before(:each) do |example|
  #   DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
  #   DatabaseCleaner.start
  # end

  # config.around(:each) do |example|
  #   # RSpec::Mocks.with_temporary_scope { double('test').as_null_object }
  #   example.run
  # end

end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end