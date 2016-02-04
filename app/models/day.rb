class Day < ActiveRecord::Base
  belongs_to :event
  has_many :sub_events
  has_many :rooms

  accepts_nested_attributes_for :sub_events, allow_destroy: true

  validates :name, :date, presence: true
  
  default_scope { order('days.created_at asc') } 

end
