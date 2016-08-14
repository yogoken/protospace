require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Protospace
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
