require_relative "boot"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

def log_stdout_and_logger(msg)
  puts msg unless ENV['NO_OUPUT'].to_s.downcase == 'true'
  Rails.logger.info(msg) if Rails.logger.present?
end

module Analytica
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for localizations and internationalizations
    config.i18n.load_path +=  Dir[Rails.root.join('config', 'locales', '*.yml')]
    config.i18n.available_locales = %i[en]
    config.i18n.default_locale = :en
    config.time_zone = "Harare"
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
