class FlightsController < ApplicationController
  before_action :check_for_admin, :only => [:new, :create]

  def index
    all_flights = Flight.all
    if params[:search_by_origin] != ""
      date = params[:search_by_date]
      origin = params[:search_by_origin]
      destination = params[:search_by_destination]
      # raise "hell"
      @flights = search_direct all_flights, date, origin, destination
      @flights.order!(:departure)

      unless @flights.any?
        @viable_routes = search_route all_flights, date, origin, destination
      end
    end
  end

  def new
    @flight = Flight.new
    @airline = Airline.find params[:airline_id]
  end

  def create
    flight = Flight.create flight_params
    airline = Airline.find params[:airline_id]
    airline.flights << flight
    redirect_to airline
  end
  
  def show
    @flight = Flight.find params[:id]
    avail_tickets = @flight.tickets.where(user_id: nil)
    @economy_tickets = avail_tickets.where("class_type = ?", 'Economy')
    @economy_available = @economy_tickets.count
    @business_tickets = avail_tickets.where("class_type = ?", "Business")
    @business_available = @business_tickets.count
  end

  def destroy
    flight = Flight.find params[:id]
    flight.destroy
    redirect_to flights_path
  end
  
  private
  
  def search_route all_flights, date, origin, destination
    inter_destination = find_unique_destinations all_flights, date, origin
    puts "new inter destinations - #{inter_destination}"
    if inter_destination.nil?
      puts "Error 0 - No flights departing on selected date from selected origin."
      return false
    end

    routes = Array.new(inter_destination.size).fill(origin).zip(inter_destination)
    puts "Step 1 - #{routes}"
    routes.map { |route|
      stop = find_unique_destinations(all_flights, date, route.last)
      puts "new stop is #{stop}"
      route << stop
      route.flatten!
      route.uniq!
    }

    viable_routes = []
    routes.each do |route|
      p route
      if (route.include? origin) && (route.include? destination)
        viable_routes << route
      end
    end
    viable_routes
  end

  def find_unique_destinations all_flights, date, origin
    puts "checking from #{origin} "
    flights = all_flights.where("DATE(departure) = ?", date).where("origin = ?", origin)
    inter_destination = []
    flights.each do |flight|
      puts "adding #{flight.destination} to inter)destination"
      inter_destination << flight.destination
    end
    inter_destination.uniq
  end

  def search_direct all_flights, date, origin, destination
    all_flights.where("origin = ?", origin).where("destination = ?", destination).where("DATE(departure) = ?", date)
  end

  def flight_params
    params.require(:flight).permit(:flight_number, :origin, :destination, :departure, :arrival)
  end
end
