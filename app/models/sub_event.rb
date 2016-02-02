class SubEvent < ActiveRecord::Base
  belongs_to :day

  validates :hour, :description, presence: true
  
  default_scope { order('hour asc') } 
end
