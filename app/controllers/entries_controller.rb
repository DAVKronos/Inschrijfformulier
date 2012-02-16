class EntriesController < ApplicationController
  before_filter :authenticate_participant!
   
  def index
    @entries = Entry.all
  end

  def new
    session[:entry_params] ||= {}
    session[:participations] ||= []
    session[:volunteer_days] ||= {}
    @entry = current_participant.build_entry(session[:entry_params])
    @entry.current_step = session[:entry_step]
    @event_participations = @entry.events
    @events = Event.all
    @days = Day.all
  end

  def create
    session[:entry_params].deep_merge!(params[:entry]) if params[:entry]
      if params[:reset_participations]
        particNumber = session[:entry_params]["event_participations_attributes"].size - 1
        session[:entry_params]["event_participations_attributes"].delete("#{particNumber}")
      end
      @entry = current_participant.build_entry(session[:entry_params])
      @entry.current_step = session[:entry_step]
      @events = Event.where("sex_id = '#{@entry.sex.id}'").select{|event| !@entry.events.include?(event)}
      @days = Day.all
      if @entry.valid?
        if params[:back_button]
          @entry.previous_step
        elsif params[:new_participation_button]
          @entry.event_participations.build
        elsif @entry.last_step?
          @entry.save if @entry.all_valid?
        elsif params[:reset_participations]
        else
          @entry.next_step
        end
     elsif params[:back_button]
         @entry.previous_step
     elsif params[:new_participation_button]
         @entry.event_participations.build
     elsif params[:reset_participations]
        @entry.event_participations.delete_all
      end
      session[:entry_step] = @entry.current_step
      if @entry.new_record?
        render "new"
      else
        session[:entry_step] = session[:entry_params] = session[:participations] = nil
        flash[:notice] = "Inschrijving bevestigd!"
        
        api_key = '256299867780027'
        api_secret = '75fb17fe91a45b35483bcc4695232df8'
        @entry.participant.publish("Ik heb me zojuist ingeschreven voor het NSK Baan!", :facebook, session[:omniauth][:credentials][:token])
        EntryMailer.welcome_email(@entry).deliver
        redirect_to @entry
      end
    end
  
  def edit
    @entry = Entry.find(params[:id])
    @entry.current_step = session[:entry_step]
    @events = Event.where("sex_id = '#{@entry.sex.id}'")
    @event_participations = @entry.events
    render'new'
  end

  def update
    @entry = Entry.find(params[:id])
    @entry.current_step = session[:entry_step]
    @events = Event.where("sex_id = '#{@entry.sex.id}'")
    @days = Day.all
    if params[:new_participation_button]
      @entry.event_participations.build
    end
    if @entry.update_attributes(params[:entry])
      if params[:back_button]
        @entry.previous_step
        session[:entry_step] = @entry.current_step
      elsif params[:new_participation_button]
      elsif params[:reset_participations]
      elsif @entry.last_step?
        last_step = true;
      else
        @entry.next_step
        session[:entry_step] = @entry.current_step
      end
      if last_step
        session[:entry_step] = session[:entry_params] = session[:participations] = nil
        @entry.entry_session.destroy
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
    @entry = Entry.find(params[:id])
    @events = @entry.events
  end

  def destroy
    entry = Entry.find(params[:id])
    entry.destroy
    flash[:success] = "Inschrijving verwijderd"
      redirect_to entries_path
  end
  
  private
      def entry_current_entry?
        @entry = Entry.find(params[:id])
        current_entry == @entry
      end
end
