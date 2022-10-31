class FlightsController < ApplicationController
  def index
    @flights = Flight.all
    if params[:search_by_origin] != ""
      @flights = @flights.where("origin = ?", params[:search_by_origin]).where("destination = ?", params[:search_by_destination])
    end
  end

  def show
    @flight = Flight.find params[:id]
    tickets = @flight.tickets
    @economy_tickets = tickets.where("class_type = ?", 'Economy').where(user_id: nil)
    @economy_available = @economy_tickets.count
    @business_tickets = tickets.where("class_type = ?", "Business").where(user_id: nil)
    @business_available = @business_tickets.count
  end
  
  private
  

end
