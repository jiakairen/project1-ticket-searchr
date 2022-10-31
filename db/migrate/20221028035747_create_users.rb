class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :email
      t.string :password_digest
      t.text :first_name
      t.text :last_name
      t.float :balance
      t.boolean :admin, :default => false

      t.timestamps
    end
  end
end
