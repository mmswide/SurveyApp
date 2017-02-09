class OrdersController < ApplicationController
  before_action :straighten_out_ticket_hash, only: :new
  before_action :sign_up_user, only: :new
  #disabeling dashboard navigation bar for this action
  before_filter :disable_nav, only: :new

  #sending tickets hash from form to the model for checking if there is enough tickets
  #building nested fields(order_tickets) for each ordered ticket
  #rendering new template if everything is ok
  def new
    coupon = Coupon.find_by(code: params[:coupon_code])
    event_id = params[:event_id]
    if ((coupon && !coupon.is_valid?) || coupon.nil? || coupon.event_id != event_id.to_i) && params[:coupon_code]
      coupon = nil
      flash[:warning] = "Coupon #{params[:coupon_code]} not valid"
    end
    @tickets = params[:tickets]
    enough_tickets = Ticket.enough_tickets?(@tickets)
    if enough_tickets
      @order = Order.new(event_id: event_id, coupon: coupon)
      @tickets.each do |id, quantity|
        quantity.to_i.times { @order.entitlements.build(ticket_id: id) }
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
    byebug
    params[:order][:user_id] = current_user.id 
    params[:order][:ip_address] = request.remote_ip
    @order = Order.new(order_params)
    if @order.save
      if @order.purchase_order
        flash[:success] = "Order successfully completed!"
        redirect_to user_path(current_user)
        UserMailer.invoice(current_user, @order).deliver_now
      else
        flash[:error] = @order.order_transactions.first.message
        render 'new', object: @order
      end
    else
      flash[:danger] = @order.errors.full_messages.to_sentence
      render 'new', object: @order
    end
  end

  private

  def order_params
    params.require(:order).permit(:coupon_id, :card_type, :card_number, 
                                  :card_cvv, :card_expires_month, :event_id,
                                  :card_expires_year, :buyer_first_name, 
                                  :buyer_last_name, :user_id, :ip_address,
                                  :ticket_amount, :address1, :city, :state, :zip, 
                                  :source_token, entitlements_attributes: [
                                                             :first_name, 
                                                             :last_name, :email,
                                                             :ticket_id
                                  ]
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
      store_location
      @user = User.new(activated: true) 
      render 'users/new', object: @user
    end
  end
end
