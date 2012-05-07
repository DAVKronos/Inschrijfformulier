class VolunteerDaysController < ApplicationController
  load_and_authorize_resource
  def index
    respond_to do |format|
      format.csv {render :csv => VolunteerDay.all
      response.headers['Content-Disposition'] = "attachment; filename=\"Vrijwilligers#{Time.now}.csv\""}
    end
  end
  
end
