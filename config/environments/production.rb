Rails.application.configure do
  config.cache_classes = true
  
  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # config.action_dispatch.rack_cache = true

  config.serve_static_files = true

  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  config.assets.compile = true

  config.assets.digest = true

  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # config.force_ssl = true

  config.log_level = :debug

  # config.log_tags = [ :subdomain, :uuid ]

  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # config.cache_store = :mem_cache_store

  # config.action_controller.asset_host = 'http://assets.example.com'

  # config.action_mailer.raise_delivery_errors = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  config.active_record.dump_schema_after_migration = false
end
