class OrderTicket < ActiveRecord::Base
  belongs_to :order 
  belongs_to :ticket 
end
