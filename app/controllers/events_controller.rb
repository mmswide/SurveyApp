class EventsController < ApplicationController
  before_action :logged_in_user
  

  def index
   @user = current_user
   @events = @user.events
  end

  def show
    @event = Event.find(params[:id])
    authorize! :update, @event
  end

  def new
    @event = Event.new({:user_id => @user_id})
  end

  def create
    @user = current_user
    @event = @user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created successfully!!"
      #redirect to index
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @event = Event.find(params[:id])
    authorize! :update, @event
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      #redirecting to the event profile if successful
      flash[:success] = "Event updated"
      redirect_to(:action => 'show', :id => @event.id)
    else
      render('edit')
    end
  end

  def delete
     @event = Event.find(params[:id])
     authorize! :update, @event
  end

  def destroy
    event = Event.find(params[:id]).destroy
     flash[:success] = "Event '#{event.event_name}' destroyed"
    redirect_to(:action => 'index')
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :event_url, :event_name, :description_short, :main_image, :description_long, :contact_name, :contact_phone, :contact_email, :venue_name, :address_1, :city, :state, :zip_code)
  end
end
