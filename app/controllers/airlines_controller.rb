class AirlinesController < ApplicationController
  before_action :check_for_admin
  
  def index
    @airlines = Airline.all
  end

  def show
    @airline = Airline.find params[:id]
  end

  def new
    @airline = Airline.new
  end

  def create
    airline = Airline.create airline_params
    redirect_to airline
  end

  def edit
    @airline = Airline.find params[:id]
  end

  def update
    airline = Airline.find params[:id]
    airline.update airline_params
    redirect_to airline
  end

  def destroy
    airline = Airline.find params[:id]
    airline.destroy
    redirect_to airlines_path
  end

  private
  def airline_params
    params.require(:airline).permit(:name, :code, :logo, :country)
  end
end
