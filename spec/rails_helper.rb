ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'
require 'capybara/rails'
require 'devise'
require 'support/controller_macros'

Capybara.javascript_driver = :poltergeist
# [重要]RSpec3ではデフォルトでspec/support/を自動的に読み込まない設定になっていたので、デフォルトでコメントアウトされているものを外す必要がある。これにより、spec/supportディレクトリ内のファイルも読み込まれるようになる
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Capybara::DSL
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryGirl::Syntax::Methods
  # ↓deviseを使って認証しているコントローラーのテストを書くための準備
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
end
