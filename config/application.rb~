require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module TicKey
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    include_necessary_folders = {
      # Include classes add more fuctions to standart Ruby and Rails Classes.
      # Date, String, DateTime, Integer, etc
      :core_ext => { :main_folder => "lib", :folder => "core_ext" },

      # Include business classes for the currect project
      :business_classes => { :main_folder => "lib", :folder => "business_classes" },
    }

    include_necessary_folders.map do |folder_key, folder_info|
      main_folder = folder_info[:main_folder]
      folder = folder_info[:folder]
      Dir[File.join(Rails.root, main_folder, folder, "*.rb")].each {|file| require file }
    end
  end
end
