class OrdersController < ApplicationController
  def new
    @order = Order.new
    @ticket_amount = params[:ticket_amount].to_i
    @ticket_id = params[:ticket_id]
    ticket = Ticket.find_by(id: @ticket_id)
    if ticket.quantity >= @ticket_amount
      @ticket_amount.times { @order.order_tickets.build }
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
end
