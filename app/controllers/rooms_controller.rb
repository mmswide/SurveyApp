class RoomsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  before_action :find_room, except: [:index, :new, :create]

  def index
    @day = Day.find_by(id: params[:day_id])
    @event = @day.event
    @rooms = smart_listing_create(:rooms, @day.rooms, 
             partial: "room_listing", array: true)
  end

  def new
    @room = Room.new(day_id: params[:day_id])
  end

  def create
    @room = Room.create(room_params)
  end

  def edit
  end

  def update
    @room.update(room_params)
  end

  def destroy
    @room.destroy
  end

  private

  def find_room
    @room = Room.find_by(id: params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :day_id)
  end
end
