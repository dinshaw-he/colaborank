require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Colaborank
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.generators do |g|
      g.test_framework :rspec, views: false
      g.helper false
      g.assets false
      g.helper_specs false
      g.controller_specs false
      g.routing false
      g.view_specs false
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
