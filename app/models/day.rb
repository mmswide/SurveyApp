class Day < ActiveRecord::Base
  belongs_to :event
  has_many :sub_events

  accepts_nested_attributes_for :sub_events, reject_if: :all_blank, allow_destroy: true
  
end
