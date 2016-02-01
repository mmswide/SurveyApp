class SubEventsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_sub_event, except: [:index, :new, :create]

  def index
    @event = Event.find_by(id: params[:event_id])
    @day = Day.find_by(id: params[:day_id])
    @sub_events = smart_listing_create(:sub_events, @day.sub_events, 
                  partial: "sub_event_listing", array: true)
  end

  def new
    @sub_event = SubEvent.new
  end

  def create
    params[:sub_event][:day_id] = params[:day_id]
    @sub_event = SubEvent.create(sub_event_params)
    @event = Event.find_by(id: params[:event_id])
    @day = Day.find_by(id: params[:day_id])
  end

  def edit
  end

  def update
    @sub_event.update(sub_event_params)
  end

  def destroy
    @sub_event.destroy
  end

  private

  def find_sub_event
    @event = Event.find_by(id: params[:event_id])
    @day = Day.find_by(id: params[:day_id])
    @sub_event = SubEvent.find_by(id: params[:id])
  end

  def sub_event_params
    params.require(:sub_event).permit(:hour, :description, :day_id)
  end
end
