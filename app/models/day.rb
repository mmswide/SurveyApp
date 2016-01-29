class Day < ActiveRecord::Base
  belongs_to :event
  has_many :sub_events

  accepts_nested_attributes_for :sub_events, allow_destroy: true

  validates :name, :date, presence: true
  
end
