require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Doctors
  class Application < Rails::Application

     config.time_zone = 'London'

    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # For Foundation 5
    config.assets.precompile += %w( vendor/modernizr )


    config.active_record.raise_in_transactional_callbacks = true
    config.assets.enabled = true 
    config.assets.initialized_on_precompile = true
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.middleware.use Rack::Attack
    config.action_controller.perform_caching = true
  end
end
