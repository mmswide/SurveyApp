class Room < ActiveRecord::Base
  belongs_to :day
  has_many :workshops

  validates :name, presence: true
end
