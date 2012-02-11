class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.all
  end

  def new
    session[:registration_params] ||= {}
    session[:participations] ||= []
    @registration = Registration.new(session[:registration_params])
    @registration.current_step = session[:registration_step]
    @event_participations = @registration.events
    @event_participation = EventParticipation.new
    @events = Event.all
  end

  def create
    session[:registration_params].deep_merge!(params[:registration]) if params[:registration]
      @registration = Registration.new(session[:registration_params])
      @registration.current_step = session[:registration_step]
      session[:participations].each do |parti|
        @registration.event_participations.build(parti)
        puts session[:participations]
      end
      @event_participation = EventParticipation.new
      @events = Event.where("sex_id = '#{@registration.sex.id}'")
      @event_participations = @registration.event_participations
      if @registration.valid?
        if params[:back_button]
          @registration.previous_step
        elsif params[:new_participation_button]
          session[:participations] << params[:event_participation]
        elsif @registration.last_step?
          @registration.save if @registration.all_valid?
        else
          @registration.next_step
        end
        session[:registration_step] = @registration.current_step
      end
      if @registration.new_record?
        render "new"
      else
        session[:registration_step] = session[:registration_params] = nil
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
