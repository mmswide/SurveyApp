class TicketsController < ApplicationController
  before_action :logged_in_user
  before_action :find_event
  
  
  def index
<<<<<<< HEAD
    @event = Event.find(params[:event_id])
=======
    @event = Event.find_by(params[:event_id])
>>>>>>> remotes/origin/stripe_payment
    @tickets = @event.tickets.sort
    authorize! :update, @event
  end

  def show
    @ticket = Ticket.find_by(params[:id])
  end

  def new
<<<<<<< HEAD
    @event = Event.find(params[:event_id])
=======
    @event = Event.find_by(params[:event_id])
>>>>>>> remotes/origin/stripe_payment
    @ticket = @event.tickets.build
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.save
    if @ticket.save
      flash[:success] = "Ticket created successfully!!"
      redirect_to event_tickets_path
    else
      render('new')
    end
  end

  def edit
<<<<<<< HEAD
    @event = Event.find(params[:event_id])
=======
    @event = Event.find_by(params[:event_id])
>>>>>>> remotes/origin/stripe_payment
    @ticket = @event.tickets.find(params[:id])
    authorize! :update, @event
  end

  def update
    @ticket = Ticket.find_by(params[:id])
    if @ticket.update_attributes(ticket_params)
      flash[:success] = "Ticket updated successfully!!"
      redirect_to event_tickets_path
    else
      render('edit')
    end
  end

  def destroy
     ticket = Ticket.find_by(params[:id]).destroy
     flash[:success] = "Ticket '#{ticket.ticket_name}' destroyed"
     redirect_to event_tickets_path
  end

  private

  def ticket_params
<<<<<<< HEAD
    params.require(:ticket).permit( :event_id, :ticket_name, :ticket_decription, :ticket_price)
=======
    params.require(:ticket).permit( :event_id, :ticket_name, 
              :ticket_description, :ticket_price, :quantity)
>>>>>>> remotes/origin/stripe_payment
  end 

  def find_event
    if params[:event_id]
      @event = Event.find(params[:event_id])
    end
  end
end
