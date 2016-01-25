class Ticket < ActiveRecord::Base
	belongs_to :event
  has_many :orders
  has_many :order_tickets, foreign_key: :ticket_id

  def self.recalculate(ordered_tickets)
    #counts amount of tickets with each id, returns a hash with ticket_id: count pairs
    tickets_occurance = ordered_tickets.pluck(:ticket_id).each_with_object(Hash.new(0)) { |ticket,counts| counts[ticket] += 1 }
    tickets_occurance.each do |id,amount| 
      ticket = Ticket.find_by(id: id)
      ticket.update_column(:quantity, (ticket.quantity-amount)) 
    end
  end

  def self.enough_tickets?(ticket_hash)
    errors = []
    ticket_hash.each do |id, quantity|
      ticket = Ticket.find_by(id: id)
      errors << "Not enough #{ticket.ticket_name} tickets left" if 
      ticket.quantity < quantity.to_i
    end
    errors.none?
  end
end
