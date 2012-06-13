Rails.application.config.middleware.use OmniAuth::Builder do
  require 'openid/store/filesystem' 
  require 'api_keys'

  #configure do |config|
  #  config.path_prefix = "/#{I18n.locale}/auth" 
  #end

  #provider :developer unless Rails.env.production?
  
  provider :github, APIConfig.github["access_key"], APIConfig.github["secret_key"]
  
  provider :facebook, APIConfig.facebook["access_key"], APIConfig.facebook["secret_key"]
  
  provider :twitter, APIConfig.twitter["access_key"], APIConfig.twitter["secret_key"]
  
  provider :google_oauth2, APIConfig.google_oauth2["access_key"],
                           APIConfig.google_oauth2["secret_key"]
  
  provider :openid, :store => OpenID::Store::Filesystem.new(APIConfig.myopenid["store_path"]), 
                    :name => APIConfig.myopenid["name"],
                    :identifier => APIConfig.myopenid["identifier"], :require => 'omniauth-openid'
end
