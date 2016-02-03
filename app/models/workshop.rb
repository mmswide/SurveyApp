class Workshop < ActiveRecord::Base
  belongs_to :room

  validates :title, :time, :location, presence: true
end
