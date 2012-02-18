class ClubsController < ApplicationController
  load_and_authorize_resource
    def index
      @clubs = Club.all
    end

    def new
      @club = Club.new
    end

    def create
      club = Club.new(params[:club])
      if club.save
        redirect_to clubs_path
      else
        render 'new'
      end
    end

    def destroy
       club = Club.find(params[:id])
        club.destroy
        flash[:success] = "Vereniging verwijderd"
          redirect_to clubs_path
    end
  end