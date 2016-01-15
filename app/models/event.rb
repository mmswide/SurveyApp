class Event < ActiveRecord::Base
	belongs_to :user
	has_many :tickets

	scope 	      :sorted, lambda { order("events.created_at DESC") }
	before_save   :downcase_event_url
	VALID_URL_REGEX = /\A[a-zA-Z0-9]{3,40}\z/
	validates :event_name, presence: true
	validates :event_url, presence: true,
				format: { with: VALID_URL_REGEX },
				uniqueness: { case_sensitive: false }
private

	def downcase_event_url
		# Converts event URLs to all lower-case.
   		 self.event_url = self.event_url.downcase
  	end

end
