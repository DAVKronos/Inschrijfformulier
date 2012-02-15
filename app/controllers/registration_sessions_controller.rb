class RegistrationSessionsController < ApplicationController
  def new
     @registration_session = RegistrationSession.new
   end

   def create
     @registration_session = RegistrationSession.new(params[:registration_session])
     if @registration_session.save
       flash[:success] = "Welkom, #{current_registration.name.split[0]}."
       redirect_to edit_registration_path(current_registration)
     else
       flash.now[:error] = "Onjuiste e-mail/wachtwoord combinatie"
       render :action => :new
     end
   end

   def destroy
     current_registration_session.destroy
     redirect_to new_registration_session_path
   end
end
