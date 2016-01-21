class Ticket < ActiveRecord::Base
	belongs_to :event
  has_many :orders
  has_many :order_tickets, foreign_key: :ticket_id
end
