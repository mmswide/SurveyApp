class Event < ActiveRecord::Base
	belongs_to :user

	scope :sorted, lambda { order("events.created_at DESC") }
end
