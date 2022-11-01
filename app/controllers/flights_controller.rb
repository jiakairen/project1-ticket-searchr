class FlightsController < ApplicationController
  def index
    all_flights = Flight.all
    if params[:search_by_origin] != ""
      date = params[:search_by_date]
      origin = params[:search_by_origin]
      destination = params[:search_by_destination]
      # raise "hell"
      @flights = search_direct all_flights, date, origin, destination
      unless @flights.any?
        search_route all_flights, date, origin, destination
      end
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
  
  def search_route all_flights, date, origin, destination
    route = [] << origin
    p route
    if search_direct(all_flights, date, origin, destination).any?
      results = search_direct(all_flights, date, origin, destination)
      return 
    end

    puts "+++++++++No direct flights found, searching route tree+++++++++++++"
    flights = all_flights.where("DATE(departure) = ?", date).where("origin = ?", origin)
    unless flights.any?
      puts "No flights departing on selected date from selected origin."
      return []
    end
    inter_flights = []
    inter_destination = []
    flights.each do |flight|
      inter_destination << flight.destination
    end
    p inter_destination.uniq!

    inter_destination.each do |origin|
      puts "searching #{origin} -> #{destination}"
      search_route all_flights, date, origin, destination
    end
  end

  def search_direct all_flights, date, origin, destination
    all_flights.where("origin = ?", origin).where("destination = ?", destination).where("DATE(departure) = ?", date)
  end
end
