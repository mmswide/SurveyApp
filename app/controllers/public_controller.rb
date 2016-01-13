class PublicController < ApplicationController
 
#layout public

  def index
  	#introductory text
  end

  def show
  	@event = Event.where(:event_url => params[:event_url]).first
  	if @event.nil?
   		redirect_to(:action => 'index')
   	else
   		render('show')
   		#show event content using show.html.erb
	end
  end
end
