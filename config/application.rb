require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProBooks
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.default_locale = :ja

    #carrirewave
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    #ng_words_validatiton
    config.autoload_paths += %W(#{config.root}/app/validators)

    config.generators do |g|
      g.test_framework :rspec,
      fixtures: false,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end
  end
end
