class Ticket < ActiveRecord::Base
	belongs_to :event
  has_many :orders
  has_many :order_tickets, foreign_key: :ticket_id

  def recalculate(ticket_amount)
    update_attribute(:quantity, quantity - ticket_amount)
  end

  def self.enough_tickets?(ticket_hash)
    errors = []
    ticket_hash.each do |id, quantity|
      ticket = Ticket.find_by(id: id)
      errors << "Not enough #{ticket.ticket_name} tickets left" if ticket.quantity < quantity.to_i
    end
    errors.none?
  end
end
