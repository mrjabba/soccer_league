require 'simplecov'
SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.include Devise::TestHelpers, :type => :controller
  config.include FactoryGirl::Syntax::Methods

#  def test_sign_in(user)
#    controller.current_user = user
#  end
end

#TODO patching below to allow specs to recognize locale routing
# remove this as soon as possible. Check again with Rails with 3.3+
# see http://www.ruby-forum.com/topic/3448797 and
# http://stackoverflow.com/questions/1987354/how-to-set-locale-default-url-options-for-functional-tests-rails/8920258#8920258
class ActionController::TestCase
  module Behavior
    def process_with_default_locale(action, parameters = nil, session =
        nil, flash = nil, http_method = 'GET')
      parameters = { :locale => I18n.default_locale }.merge( parameters || {} )
      process_without_default_locale(action, parameters, session, flash, http_method)
    end
    alias_method_chain :process, :default_locale
  end
end

module ActionDispatch::Assertions::RoutingAssertions
  def assert_recognizes_with_default_locale(expected_options, path,
      extras={}, message=nil)
    expected_options = { :locale => I18n.default_locale.to_s
    }.merge(expected_options || {} )
    assert_recognizes_without_default_locale(expected_options, path,
                                             extras, message)
  end
  alias_method_chain :assert_recognizes, :default_locale
end