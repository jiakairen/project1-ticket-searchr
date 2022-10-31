class CreateAirlines < ActiveRecord::Migration[5.2]
  def change
    create_table :airlines do |t|
      t.text :name
      t.text :code
      t.text :logo
      t.text :country

      t.timestamps
    end
  end
end
