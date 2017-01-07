class TicketsController < ApplicationController
  before_action :logged_in_user
  before_action :find_event
  
  
  def index
    @event = Event.find_by(id: params[:event_id])
    @tickets = @event.tickets.sort
    authorize! :update, @event
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])
  end

  def new
    @event = Event.find_by(id: params[:event_id])
    @ticket = @event.tickets.build
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.save
    if @ticket.save
      flash[:success] = "Ticket created successfully!!"
      redirect_to new_event_ticket_path
    else
      render('new')
    end
  end

  def edit
    @event = Event.find_by(id: params[:event_id])
    @ticket = @event.tickets.find(params[:id])
    authorize! :update, @event
  end

  def update
    @ticket = Ticket.find_by(id: params[:id])
    if @ticket.update_attributes(ticket_params)
      flash[:success] = "Ticket updated successfully!!"
      redirect_to event_tickets_path
    else
      render('edit')
    end
  end

  def destroy
     ticket = Ticket.find_by(id: params[:id]).destroy
     flash[:success] = "Ticket '#{ticket.ticket_name}' destroyed"
     redirect_to event_tickets_path
  end

  private

  def ticket_params
    params.require(:ticket).permit( :event_id, :ticket_name, 
              :ticket_description, :ticket_price, :quantity)
  end 

  def find_event
    if params[:event_id]
      @event = Event.find(params[:event_id])
    end
  end
end
