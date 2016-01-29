class SubEvent < ActiveRecord::Base
  belongs_to :day

  validates :hour, :description, presence: true
end
