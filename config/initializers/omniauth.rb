Rails.application.config.middleware.use OmniAuth::Builder do   
  provider :facebook, '256299867780027', '75fb17fe91a45b35483bcc4695232df8'  
end