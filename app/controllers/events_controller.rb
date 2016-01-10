class EventsController < ApplicationController
  def index
    @events = Event.sorted
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
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
  end

  def destroy
    event = Event.find(params[:id]).destroy
     flash[:success] = "Event '#{event.event_name}' destroyed"
    redirect_to(:action => 'index')
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :description_short, :description_long)
  end
end
