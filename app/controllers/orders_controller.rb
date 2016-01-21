class OrdersController < ApplicationController
  def new
    @order = Order.new
    #need to check if current amount is available and set variable for it 
    #or redirect back with a flash[:warning]
    @ticket_amount = 2
    @ticket_amount.times { @order.order_tickets.build }
  end
  def create
    params[:order][:user_id] = current_user.id if current_user.present?
    params[:order][:ip_address] = request.remote_ip
    @order = Order.new(order_params)
     if @order.save
      if @order.purchase_order
        raise @order.order_transactions.inspect
      else
        raise @order.order_transactions.inspect
      end
     else
      raise @order.errors.full_messages.inspect
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
