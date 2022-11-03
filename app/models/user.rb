class User < ApplicationRecord
    has_secure_password
    validates :email, :uniqueness => true, :presence => true
    has_many :tickets

    def money_spent
        spent = 0
        self.tickets.each do |ticket|
            spent += ticket.price
        end
        spent
    end
end
