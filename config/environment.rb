# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Wantatoy::Application.initialize!

# Initilialize APP_CONFIG hash (the config.yml file should not be commited to the repository!!!)
APP_CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/config.yml")