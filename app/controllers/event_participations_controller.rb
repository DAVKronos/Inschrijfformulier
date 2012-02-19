class EventParticipationsController < ApplicationController
  def destroy
      event_participation = EventParticipation.find(params[:id])
        event_participation.destroy
        flash[:success] = "Onderdeeldeelname verwijderd"
          redirect_to edit_entry_path(current_participant.entry)
  end
end
