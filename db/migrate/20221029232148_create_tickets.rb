class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.float :price
      t.text :class_type

      t.timestamps
    end
  end
end
