class Flight < ApplicationRecord
    belongs_to :airline, :optional => true
    has_many :tickets
end
