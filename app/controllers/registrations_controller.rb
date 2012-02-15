class RegistrationsController < ApplicationController
  access_control do
          actions :edit, :update do
            allow logged_in, :if => :registration_current_registration?
          end
          actions :new, :index, :create do
            allow all
          end
      end
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
    @events = Event.all
    @days = Day.all
  end

  def create
    session[:registration_params].deep_merge!(params[:registration]) if params[:registration]
      if params[:reset_participations]
        particNumber = session[:registration_params]["event_participations_attributes"].size - 1
        session[:registration_params]["event_participations_attributes"].delete("#{particNumber}")
      end
      @registration = Registration.new(session[:registration_params])
      @registration.current_step = session[:registration_step]
      @events = Event.where("sex_id = '#{@registration.sex.id}'").select{|event| !@registration.events.include?(event)}
      @days = Day.all
      if @registration.valid?
        if params[:back_button]
          @registration.previous_step
        elsif params[:new_participation_button]
          @registration.event_participations.build
        elsif @registration.last_step?
          @registration.save if @registration.all_valid?
        elsif params[:reset_participations]
        else
          @registration.next_step
        end
     elsif params[:back_button]
         @registration.previous_step
     elsif params[:new_participation_button]
         @registration.event_participations.build
     elsif params[:reset_participations]
        @registration.event_participations.delete_all
      end
      session[:registration_step] = @registration.current_step
      if @registration.new_record?
        render "new"
      else
        session[:registration_step] = session[:registration_params] = session[:participations] = nil
        flash[:notice] = "Inschrijving bevestigd!"
        RegistrationMailer.welcome_email(@registration).deliver
        redirect_to @registration
      end
    end
  
  def edit
    @registration = Registration.find(params[:id])
    @registration.current_step = session[:registration_step]
    @events = Event.where("sex_id = '#{@registration.sex.id}'")
    @event_participations = @registration.events
    render'new'
  end

  def update
    @registration = Registration.find(params[:id])
    @registration.current_step = session[:registration_step]
    @events = Event.where("sex_id = '#{@registration.sex.id}'")
    @days = Day.all
    if params[:new_participation_button]
      @registration.event_participations.build
    end
    if @registration.update_attributes(params[:registration])
      if params[:back_button]
        @registration.previous_step
        session[:registration_step] = @registration.current_step
      elsif params[:new_participation_button]
      elsif params[:reset_participations]
      elsif @registration.last_step?
        last_step = true;
      else
        @registration.next_step
        session[:registration_step] = @registration.current_step
      end
      if last_step
        session[:registration_step] = session[:registration_params] = session[:participations] = nil
        @registration.registration_session.destroy
        flash[:success] = "Inschrijving geupdated."
        redirect_to :root
      else
        render 'new' unless last_step
      end
  else
    render 'new'
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
  
  private
      def registration_current_registration?
        @registration = Registration.find(params[:id])
        current_registration?(@registration)
      end
end
