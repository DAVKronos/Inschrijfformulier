Rails.application.config.middleware.use OmniAuth::Builder do   
  provider :facebook, Settings.facebook_appid, Settings.facebook_appsecret, :scope => 'publish_stream,email,offline_access'
end