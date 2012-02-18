class EntryMailer < ActionMailer::Base
  default from: "Kegel de Egel <kegel@kronos.nl>"
  
  def welcome_email(user)
      @user = user
      @url  = "https://inschrijven.kronos.nl/login"
      mail(:to => user.participant.email, :subject => "Bedankt voor je aanmelding, #{@user.name.split[0]}")
    end
end
