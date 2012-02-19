class ApplicationController < ActionController::Base
  before_filter :mailer_set_url_options
  layout :set_layout
 
 
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
  
  def after_sign_in_path_for(resource)
        #return request.env['omniauth.origin'] || stored_location_for(resource) || new_entry_path
        new_entry_path
    end
    
  def current_ability
    @current_ability ||= Ability.new(current_participant)
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "Je hebt geen toegang tot deze pagina"
  end

  private
    def set_layout
      if request.headers['X-PJAX']
        "pjax"
      else
        "application"
      end
    end
end
