class TicketsController < ApplicationController
  before_action :check_for_login
  def show
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
end
