class Event < ActiveRecord::Base
	belongs_to :user
	has_many :tickets
	has_many :orders
	 #Paperclip gem Profile Image for events. The hash at the end of 150150 crops the image to that size
	has_attached_file :main_image, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\Z/

	scope 	      :sorted, lambda { order("events.created_at DESC") }
	before_save   :downcase_event_url
	#before_save   :downcase_email
	#before_save	  :strip_number
	VALID_URL_REGEX = /\A[a-zA-Z0-9]{3,40}\z/
	validates :event_name, presence: true
	validates :event_url, presence: true,
				format: { with: VALID_URL_REGEX },
				uniqueness: { case_sensitive: false }


	private

	def downcase_event_url
		#Converts event URLs to all lower-case.
   		self.event_url = self.event_url.downcase
  	end

end
