class Event < ActiveRecord::Base
	belongs_to :user
	has_many :tickets

	scope 	      :sorted, lambda { order("events.created_at DESC") }
	before_save   :downcase_event_url
	#before_save   :downcase_email
	#before_save	  :strip_number
	VALID_URL_REGEX = /\A[a-zA-Z0-9]{3,40}\z/
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :contact_email, allow_blank: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX , message: " - Should be in frank@dancer.com format" }
	validates :event_name, presence: true
	validates :event_url, presence: true,
				format: { with: VALID_URL_REGEX },
				uniqueness: { case_sensitive: false }

	 validates :contact_phone, length: {minimum: 9, maximum: 18,
	 	too_short: "must have at least %{count} numbers. format: (xxx)-xxx-xxxx, remember the area code",
    	too_long: "Is a bit long. Max: %{count} digits, format: (xxx)-xxx-xxxx"
	 	}, allow_blank: true
	

	private

	def downcase_event_url
		#Converts event URLs to all lower-case.
   		self.event_url = self.event_url.downcase
  	end

 # 	def strip_number
  #   	self.contact_phone = self.contact_phone.gsub(/[^0-9]/, "")
   #	end

  # 	def downcase_email
   # 	self.contact_email = self.contact_email.downcase
  	# end
end
