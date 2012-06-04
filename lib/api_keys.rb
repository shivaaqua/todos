# Load api keys configuration
require 'ostruct'
require 'yaml'

config = OpenStruct.new(YAML.load_file("#{Rails.root}/config/api_keys.yml"))
::APIConfig = OpenStruct.new(config.send(Rails.env))

