class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.all
  end

  def new
    @registration = Registration.new
  end

  def create
    registration = Registration.new(params[:registration])
    if registration.save
      flash[:succes] = "Inschrijving voltooid"
      redirect_to registration
    else
      render 'new'
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
  end

  def destroy
    registration = Registration.find(params[:id])
    registration.destroy
    flash[:success] = "Inschrijving verwijderd"
      redirect_to registrations_path
  end
end
