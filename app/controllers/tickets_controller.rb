class TicketsController < ApplicationController
  before_action :check_for_login
  def show
    @ticket = Ticket.find params[:id]
  end

  def new
    @ticket = Ticket.new
    @flight = Flight.find params[:flight_id]
    @airline = Airline.find params[:airline_id]
  end

  def create
    qty = qty_params.values.first.to_i
    flight = Flight.find params[:flight_id]
    qty.times do 
      ticket = Ticket.create ticket_params
      flight.tickets << ticket
    end
    redirect_to flight_path(flight)
  end

  def complete
    ticket = Ticket.find params[:id]
    ticket.user_id = @current_user.id
    ticket.save
    redirect_to user_path(@current_user.id)
  end

  def cancel
    @ticket = Ticket.find params[:id]
  end

  def unlink
    ticket = Ticket.find params[:id]
    ticket.user_id = nil
    ticket.save
    redirect_to user_path(@current_user.id)
  end

  private
  def ticket_params
    params.require(:ticket).permit(:price, :class_type)
  end

  def qty_params
    params.permit(:qty)
  end
end
