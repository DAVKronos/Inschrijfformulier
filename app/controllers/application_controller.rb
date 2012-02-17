class ApplicationController < ActionController::Base
  before_filter :mailer_set_url_options
 
 
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
  
  def after_sign_in_path_for(resource)
        #return request.env['omniauth.origin'] || stored_location_for(resource) || new_entry_path
        new_entry_path
    end
end
