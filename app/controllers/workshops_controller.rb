class WorkshopsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  before_action :find_workshop, except: [:index, :new, :create]

  def index
    @room = Room.find_by(id: params[:room_id])
    @event = @room.day.event
    @workshops = smart_listing_create(:workshops, @room.workshops, 
             partial: "workshop_listing", array: true)
  end

  def new
    @workshop = Workshop.new(room_id: params[:room_id])
  end

  def create
    @workshop = Workshop.create(workshop_params)
  end

  def edit
  end

  def update
    @workshop.update(workshop_params)
  end

  def destroy
    @workshop.destroy
  end

  private

  def find_workshop
    @workshop = Workshop.find_by(id: params[:id])
  end

  def workshop_params
    params.require(:workshop).permit(:title, :room_id, :time, :instructor, 
                                     :level, :location, :category)
  end
end
