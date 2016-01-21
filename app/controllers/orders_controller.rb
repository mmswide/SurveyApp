class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order_transaction = OrderTransaction.new
  end
  def create
    @order = Order.purchase_order(order_params)
  end

  private

  def order_params
    params.require(:order).permit(:ticket_id, :card_type, :card_number, 
                                  :card_cvv, :card_expires_month, 
                                  :card_expires_year, :first_name, :last_name, 
                                  :ticket_amount, :adress, :city, :state, :zip
    )
  end

end
