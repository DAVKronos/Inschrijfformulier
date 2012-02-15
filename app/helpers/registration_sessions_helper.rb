module RegistrationSessionsHelper

  def current_registration?(registration)
    registration == current_registration
  end

  def current_registration_session
    @current_registration_session ||= RegistrationSession.find
  end

  def current_registration
    @current_registration ||= current_registration_session && current_registration_session.registration
  end
end
