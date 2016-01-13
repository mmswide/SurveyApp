class Event < ActiveRecord::Base
	belongs_to :user
	has_many :tickets

	scope :sorted, lambda { order("events.created_at DESC") }
end
