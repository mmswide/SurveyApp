class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
     @ticket.save
    if @ticket.save
      flash[:success] = "Ticket created successfully!!"
      redirect_to(:action =>'index')
    else
      render('new')
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(ticket_params)
      flash[:success] = "Ticket updated successfully!!"
      redirect_to(:action =>'index')
    else
      render('edit')
    end
  end

  def delete
    @ticket = Ticket.find(params[:id])
  end

  def destroy
     ticket = Ticket.find(params[:id]).destroy
     flash[:success] = "Ticket '#{ticket.ticket_name}' destroyed"
    redirect_to(:action => 'index')
  end

  private

  def ticket_params
    params.require(:ticket).permit(:ticket_name, :ticket_decription, :ticket_price)
  end 

end
