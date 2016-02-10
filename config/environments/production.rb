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
    config.action_mailer.default_url_options = { 
	    :host => 'obscure-cliffs-1401.herokuapp.com', 
	    :from => 'notifications@thedoctors.com'
    }
    #add Heroku url
   # Rails.application.routes.default_url_options[:host] = ''
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = false

    config.action_mailer.smtp_settings = {
	    address: "smtp.gmail.com",
	    port: 587,
	    domain: ENV["GMAIL_DOMAIN"],
	    authentication: :plain,
	    enable_starttls_auto: true,
	    user_name: ENV["GMAIL_USERNAME"],
	    password: ENV["GMAIL_PASSWORD"]
    }

    Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['SEARCHBOX_SSL_URL']
end
