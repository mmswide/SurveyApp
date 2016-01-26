class Entitlement < ActiveRecord::Base
  belongs_to :order 
  belongs_to :ticket 

  validates :first_name, :last_name, :email, :ticket, presence: true

  before_save :set_description


  private

  def set_description
    self.description = self.ticket.ticket_description
  end
end
