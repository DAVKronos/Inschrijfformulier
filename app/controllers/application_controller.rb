class ApplicationController < ActionController::Base
  before_filter :mailer_set_url_options
 
 
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
