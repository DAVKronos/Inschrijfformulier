class RegistrationMailer < ActionMailer::Base
  default from: "kegel@kronos.nl"
  
  def welcome_email(user)
      @user = user
      @url  = "https://inschrijven.kronos.nl"
      mail(:to => user.email, :subject => "#{@user.name.split[0]}")
    end
end
