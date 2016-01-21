class OrdersController < ApplicationController
  def new
    @order = Order.new
    #need to check if current amount is available and set variable for it 
    #or redirect back with a flash[:warning]
    @ticket_count = 3
  end
  def create
    params[:order][:user_id] = current_user.id if current_user.present?
    @order = Order.new(order_params)
  end

  private

  def order_params
    params.require(:order).permit(:ticket_id, :card_type, :card_number, 
                                  :card_cvv, :card_expires_month, 
                                  :card_expires_year, :buyer_first_name, 
                                  :buyer_last_name, :user_id
                                  :ticket_amount, :adress1, :city, :state, :zip,
                                  :tickets[:first_name, :last_name, :email]
    )
  end

end
