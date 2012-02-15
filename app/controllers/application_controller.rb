class ApplicationController < ActionController::Base
  protect_from_forgery
  include RegistrationSessionsHelper
  
  rescue_from Acl9::AccessDenied, :with => :registration_not_authorized

    private

    def registration_not_authorized
      flash[:error] = "Voor toegang a.u.b. inloggen"
      redirect_to :signin
    end
end
