class EntryMailer < ActionMailer::Base
  add_template_helper(EntriesHelper)
  default from: "Kegel de Egel <kegel@kronos.nl>"
  
  def welcome_email(entry)
      @entry = entry
      mail(:to => entry.participant.email, :subject => "Bedankt voor je aanmelding, #{entry.name.split[0]}")
    end
end
