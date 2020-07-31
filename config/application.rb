require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kalique
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.x.vk_app_id = ENV['VK_APP_ID']
    config.x.vk_secret = ENV['VK_SECRET']
    config.x.vk_service = ENV['VK_SERVICE']
    config.x.posts_domain = 'kalikfan'

    config.x.admin_login = ENV['ADMIN_LOGIN']
    config.x.admin_password = ENV['ADMIN_PASSWORD']
  end
end
