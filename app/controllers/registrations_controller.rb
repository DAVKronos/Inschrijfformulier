class RegistrationsController < Devise::RegistrationsController
  
  def create
    super
    session[:omniauth] = nil unless @participant.new_record? 
  end
  
  def edit
    @participant = current_participant
  end

  def update
    @participant = Participant.find(current_participant.id)
    if @participant.update_attributes(params[:participant])
      # Sign in the user by passing validation in case his password changed
      sign_in @participant, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end
  
  private
  def build_resource(*args)
    super
    if session[:omniauth]
      @participant.apply_omniauth(session[:omniauth])
      @participant.valid?
    end
  end
end