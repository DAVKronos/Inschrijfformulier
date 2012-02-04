class SexesController < ApplicationController
    def index
      @sexes = Sex.all
    end

    def new
      @sex = Sex.new
    end

    def create
      sex = Sex.new(params[:sex])
      if sex.save
        redirect_to sexes_path
      else
        render 'new'
      end
    end

    def destroy
       sex = Sex.find(params[:id])
        sex.destroy
        flash[:success] = "geslacht verwijderd"
          redirect_to sexes_path
    end
  end
