class AuthenticationsController < ApplicationController
  def index
    @authentications = current_participant.authentications if current_participant
  end


  def create
    omniauth = request.env["omniauth.auth"]
    session['fb_access_token'] = omniauth['credentials']['token']
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    puts authentication
    if authentication
      flash[:notice] = "Signed in successfully."
      authentication.participant
      sign_in_and_redirect(:participant, authentication.participant)
    elsif current_participant
      current_participant.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      unless omniauth['info']['email'].blank?
        participant = Participant.find_or_initialize_by_email_and_name(omniauth['info']['email'],omniauth['info']['name'])
      end
      participant.apply_omniauth(omniauth)
      if participant.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:participant, participant)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_participant_registration_url
      end
    end
  end

  def destroy
     @authentication = current_participant.authentications.find(params[:id])
     @authentication.destroy
     flash[:notice] = "Successfully destroyed authentication."
     redirect_to authentications_url
  end
end
