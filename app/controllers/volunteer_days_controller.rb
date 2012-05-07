class VolunteerDaysController < ApplicationController
  def index
    respond_to do |format|
      format.csv {render :csv => VolunteerDay.all
      response.headers['Content-Disposition'] = "attachment; filename=\"Vrijwilligers#{Time.now}.csv\""}
    end
  end
  
end
