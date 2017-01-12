require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:tickets) { create_list(:ticket, 2) }
  before(:each) do |bfr|
    unless bfr.metadata[:skip_before]
      log_in user
    end
  end
  describe "GET #new" do
    context 'enough tickets' do
      before(:each) do
        get :new, event_id: 1, tickets: { tickets.first.id => 3, tickets.last.id => 2 }
        controller.class.skip_before_filter :straighten_out_ticket_hash
      end
      it 'assigns new order to @order' do
        expect(assigns(:order)).to be_a_new(Order)
      end
      it 'assigns new order with event_id' do
        expect(assigns(:order).event_id).to eq(1)
      end
      it 'builds entitlements for order' do
        expect(assigns(:order).entitlements).not_to be_empty
      end
      it 'renders new template' do
        expect(response).to render_template('new')
      end
    end
    context 'not enough tickets' do
      before(:each) do
        @request.env['HTTP_REFERER'] = 'http://localhost:3000/'
        get :new, event_id: 1, tickets: { tickets.first.id => 24, tickets.last.id => 2 }
        controller.class.skip_before_filter :straighten_out_ticket_hash
      end
      it 'redirects to back' do
        expect(response).to redirect_to(:back)
      end
      it 'flashes warning' do
        expect(controller).to set_flash[:warning]
      end
    end
  end
  describe "POST #create" do
    context 'valid attributes' do
      before(:each) do
        @event = create(:event)
        post :create, order: attributes_for(:order, event_id: @event.id) 
      end
      it 'saves the order to the database' do
        expect {
          post :create, order: attributes_for(:order, event_id: @event.id) 
        }.to change(Order, :count).by(1)
      end
      it 'redirects to users show page' do
        expect(response).to redirect_to(user_path(user))
      end
      it 'flashes success' do
        expect(controller).to set_flash[:success]
      end
    end
    context 'unvalid attributes' do
      before(:each) do
        post :create, order: attributes_for(:order, event_id: nil) 
      end
      it "doesn't saves the order to the database" do
        expect {
          post :create, order: attributes_for(:order, event_id: nil) 
        }.not_to change(Order, :count)
      end
      it 'renders new template' do
        expect(response).to render_template('new')
      end
      it 'flashes danger' do
        expect(controller).to set_flash[:danger]
      end
    end
  end
  describe "GET #sign_up_user", :skip_before do
    before(:each) do
      get :new, event_id: 1, tickets: { tickets.first.id => 3, tickets.last.id => 2 } 
    end
    it 'assigns new User to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'sets activated field in @user to true' do
      expect(assigns(:user).activated).to be_truthy 
    end
    it 'renders users/new template' do
      expect(response).to render_template('users/new')
    end
    it 'is not getting trigered if user is logged in' do
      user = create(:user)
      log_in user
      get :new, event_id: 1, tickets: { tickets.first.id => 3, tickets.last.id => 2 } 
      expect(response).to render_template('new')
    end
  end

  describe 'Orders with applied coupons' do
      
    before :each do
      post_order
    end

    before :context do
      @coupon = FactoryGirl.create(:coupon, code: '1234')
    end
    
    context 'with percent type' do
      it 'saves the order to the database with coupon reference' do
        expect(Order.last.coupon.present?).to be_truthy
      end

      it 'set correct discounted order value' do
        ticket_price_cents = (@ticket.ticket_price.to_f.round(2)*100).to_i
        discount_cents = @coupon.discount_cents(ticket_price_cents)
        expect(Order.last.raw_price).to eql ticket_price_cents - discount_cents
      end
    end

    before :context do
      @coupon = FactoryGirl.create(:coupon, discount_type: 'fixed_amount', discount_amount_cents: 500, code: '123')
    end

    context 'with fixed_amount type' do
      it 'set correct discounted order value' do
        ticket_price_cents = (@ticket.ticket_price.to_f.round(2)*100).to_i
        discount_cents = @coupon.discount_cents(ticket_price_cents)
        expect(Order.last.raw_price).to eql ticket_price_cents - discount_cents
      end
    end

    def post_order
      @event = create(:event)
      @ticket = FactoryGirl.create(:ticket, event: @event)
      post :create, order: attributes_for(
        :order, 
        event_id: @event.id, 
        coupon_id: @coupon.id,
        entitlements_attributes: {"0"=>{"first_name"=>"Test", "last_name"=>"Last", "email"=>"em@em.com", "ticket_id"=>@ticket.id}}
      ) 
    end
  end    
end

