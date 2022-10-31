class AddFlightIdToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :flight_id, :integer
  end
end
