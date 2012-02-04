class CollegesController < ApplicationController
  def index
    @colleges = College.all
  end

  def new
    @college = College.new
  end

  def create
    college = College.new(params[:college])
    if college.save
      redirect_to colleges_path
    else
      render 'new'
    end
  end

  def destroy
     college = College.find(params[:id])
      college.destroy
      flash[:success] = "Universiteit/Hogeschool verwijderd"
        redirect_to colleges_path
  end
end
