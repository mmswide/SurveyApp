class DaysController < ApplicationController
  def destroy
    @day = Day.find_by(id: params[:id])
    @event = @day.event
    @day.destroy
  end

  def update
    @day = Day.find_by(id: params[:id])
    respond_to do |format|
      @day.update_attributes(day_params)
      format.json { respond_with_bip(@day) }
    end
  end

  def index
    @event = Event.find_by(id: params[:event_id])
  end

  private

  def day_params
    params.require(:day).permit(:name, :date)
  end
end
