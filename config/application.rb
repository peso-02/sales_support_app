require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SalesSupportApp
  class Application < Rails::Application
    config.load_defaults 7.1
    
    # 日本語をデフォルトに設定
    config.i18n.default_locale = :ja
    
    # タイムゾーンも日本に
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end

