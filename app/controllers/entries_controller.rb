class EntriesController < ApplicationController
  load_and_authorize_resource
  before_filter :has_no_entry?, :only => [:new, :create]
  
   
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
    @entry.name = current_participant.name
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
        
        if !@entry.participant.authentications.empty?
          @entry.participant.publish("Ik heb me zojuist ingeschreven voor het NSK Baan!", :facebook, session['fb_access_token'])
        end
        
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
      @entry.event_participations.create
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
        sign_out(@entry.participant)
        flash[:success] = "Inschrijving bijgewerkt."
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
  
  def home
  end
  
  private
      def participant_current_participant?
        @entry = Entry.find(params[:id])
        if current_participant != @entry.participant
          redirect_to root_path
        end
      end
      
      def has_no_entry?
         if current_participant.entry && !current_participant.entry.new_record?
            redirect_to edit_entry_path(current_participant.entry)
         end
      end
      
      
      def get_facebook_token
        client = OAuth2::Client.new(Settings.facebook_appid, Settings.facebook_appsecret, :site => 'https://graph.facebook.com')
        token = OAuth2::AccessToken.new(client, session['fb_access_token'])
        
        return token
      end
         
end
