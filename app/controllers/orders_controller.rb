class OrdersController < ApplicationController
  before_action :straighten_out_tickets, only: :new

  def new
    #sending tickets hash from form to the model for checking if there is enough tickets
    enough_tickets = Ticket.enough_tickets?(params[:tickets])
    if enough_tickets
      @all_tickets_count = 0
      @order = Order.new
      params[:tickets].each do |id, quantity|
        quantity.to_i.times { @order.order_tickets.create(ticket_id: id) }
        @all_tickets_count += quantity.to_i
      end
    else
      flash[:warning] = 'Not enough available tickets'
      redirect_to(:back)
    end
  end

  def create
    params[:order][:user_id] = current_user.id if current_user.present?
    params[:order][:ip_address] = request.remote_ip
    @order = Order.new(order_params)
    if @order.save
      if @order.purchase_order
        flash[:success] = "Order successfully completed!"
        redirect_to user_path(current_user)
      else
        flash[:error] = @order.order_transactions.first.message
        render 'new', object: @order
      end
    else
      flash[:error] = @order.errors.full_messages.to_sentence
      render 'new', object: @order
    end
  end

  private

  def order_params
    params.require(:order).permit(:card_type, :card_number,
                                  :card_cvv, :card_expires_month, 
                                  :card_expires_year, :buyer_first_name, 
                                  :buyer_last_name, :user_id, :ip_address,
                                  :ticket_amount, :address1, :city, :state, :zip,
                                  order_tickets_attributes: [
                                                             :first_name, 
                                                             :last_name, :email,
                                                             :ticket_id
                                  ]
    )
  end

  def straighten_out_tickets
    params[:tickets] = params[:tickets].first.delete_if { |k, v| v.blank? }
  end
end
