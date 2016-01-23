class OrderTicket < ActiveRecord::Base
  belongs_to :order 
  belongs_to :ticket 

  validates :first_name, :last_name, :email, :ticket, presence: true

end
