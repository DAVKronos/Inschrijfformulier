class DaysController < ApplicationController
      def index
        @days = Day.all
      end

      def new
        @day = Day.new
      end

      def create
        day = Day.new(params[:day])
        if day.save
          redirect_to days_path
        else
          render 'new'
        end
      end

      def destroy
         day = Day.find(params[:id])
          day.destroy
          flash[:success] = "Dag verwijderd"
            redirect_to days_path
      end
end
