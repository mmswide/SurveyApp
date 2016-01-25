class OrdersController < ApplicationController
  before_action :straighten_out_ticket_hash, only: :new
  before_action :sign_up_user, only: :create

  #sending tickets hash from form to the model for checking if there is enough tickets
  #building nested fields(order_tickets) for each ordered ticket
  #rendering new template if everything is ok
  def new
    enough_tickets = Ticket.enough_tickets?(params[:tickets])
    if enough_tickets
      @new_user = User.new if current_user.blank?
      @order = Order.new
      params[:tickets].each do |id, quantity|
        quantity.to_i.times { @order.order_tickets.build(ticket_id: id) }
      end
    else
      flash[:warning] = 'Not enough available tickets'
      redirect_to(:back)
    end
  end
  #creating a new order, if success - then performing a purchase
  #if success - redirecting to users profile
  #otherwise - re-rendering #new template and displaying errors
  def create
    params[:order][:user_id] = current_user.id 
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

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation
    )
  end

  #because hash that comes from a form is a mess, it's getting parsed here
  def straighten_out_ticket_hash
    params[:tickets] = params[:tickets].first.delete_if { |k, v| v.blank? }
  end
  #checking if the user is logged_in
  #if not - creating one before proceeding buying process
  def sign_up_user
    unless current_user.present?
      @new_user = User.create(user_params)
      if @new_user.save
        log_in @new_user
      else
        @order = Order.new(order_params)
        render 'new', object: [@order, @new_user]
      end
    end
  end
end