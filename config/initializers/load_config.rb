APP_CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/config.yml")[::Rails.env]
FB_APP_NAMESPACE=ENV['FB_APP_NAMESPACE']
FB_SL_APP_ID=ENV['FB_SL_APP_ID']
