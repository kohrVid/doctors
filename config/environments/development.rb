Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true

  config.action_mailer.default_options = {
 	  :host => 'localhost:3000',
	  :from => "notifications@kohrVid.com" 
  }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
	  address: "smtp.gmail.com",
	  port: 587,
	  domain: ENV["GMAIL_DOMAIN"],
	  authentication: :plain,
	  enable_starttls_auto: true,
	  user_name: ENV["GMAIL_USERNAME"],
	  password: ENV["GMAIL_PASSWORD"]
  }
  
  config.serve_static_files = true

  # config.action_view.raise_on_missing_translations = true
end
