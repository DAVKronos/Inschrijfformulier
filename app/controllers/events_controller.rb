class EventsController < ApplicationController
  def index
    @events = Event.includes(:event_participations, :sex, {:entries => :club}).all
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(params[:event])
    if event.save
      redirect_to events_path
    else
      render 'new'
    end
  end
  
  def edit
     @event = Event.find(params[:id])
   end

   def update
     event = Event.find(params[:id])
     if event.update_attributes(params[:event])
       flash[:success] = "Onderdeel geupdated."
       redirect_to event
     else
       render 'edit'
     end
   end

  def destroy
     event = Event.find(params[:id])
      event.destroy
      flash[:success] = "Onderdeel verwijderd"
        redirect_to events_path
  end
end

