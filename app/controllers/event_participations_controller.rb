class EventParticipationsController < ApplicationController
  def destroy
      event_participation = EventParticipation.find(params[:id])
        event_participation.destroy
        flash[:success] = "Onderdeeldeelname verwijderd"
          redirect_to edit_entry_path(current_participant.entry)
  end
  
  def index
    respond_to do |format|
      format.csv {render :csv => EventParticipation.all
      response.headers['Content-Disposition'] = "attachment; filename=\"OnderdelenDeelnemers#{Time.now}.csv\""}
    end
  end
  
end
