class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.all
  end

  def new
    session[:registration_params] ||= {}
    session[:participations] ||= []
    session[:volunteer_days] ||= {}
    @registration = Registration.new(session[:registration_params])
    @registration.current_step = session[:registration_step]
    @event_participations = @registration.events
    @event_participation = EventParticipation.new
    @events = Event.all
    @days = Day.all
  end

  def create
    session[:registration_params].deep_merge!(params[:registration]) if params[:registration]
      @registration = Registration.new(session[:registration_params])
      @registration.current_step = session[:registration_step]
      @event_participation = EventParticipation.new
      @events = Event.where("sex_id = '#{@registration.sex.id}'").select{|event| !@registration.events.include?(event)}
      @days = Day.all
      if @registration.valid?
        if params[:back_button]
          @registration.previous_step
        elsif params[:new_participation_button]
          @registration.event_participations.build
        elsif @registration.last_step?
          @registration.save if @registration.all_valid?
        else
          @registration.next_step
        end
     elsif params[:back_button]
         @registration.previous_step
     elsif params[:new_participation_button]
         @registration.event_participations.build
     end
      session[:registration_step] = @registration.current_step
      if params[:cancel_button]
        session[:registration_step] = session[:registration_params] = session[:participations] = nil
        redirect_to "http://www.youtube.com/watch?v=dQw4w9WgXcQ&ob=av2e"
      elsif @registration.new_record?
        render "new"
      else
        session[:registration_step] = session[:registration_params] = session[:participations] = nil
        flash[:notice] = "Inschrijving bevestigd!"
        redirect_to @registration
      end
    end
  
  def edit
    @registration = Registration.find(params[:id])
  end

  def update
    registration = Registration.find(params[:id])
    if registration.update_attributes(params[:registration])
      flash[:success] = "Inschrijving geupdated."
      redirect_to registration
    else
      render 'edit'
    end
  end

  def show
    @registration = Registration.find(params[:id])
    @events = @registration.events
  end

  def destroy
    registration = Registration.find(params[:id])
    registration.destroy
    flash[:success] = "Inschrijving verwijderd"
      redirect_to registrations_path
  end
end
