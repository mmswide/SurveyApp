require 'rails_helper'

RSpec.describe CouponsController, type: :controller do

  let(:event){FactoryGirl.create(:event)}
  let(:valid_attributes) {
    { description: 'Some description',
      code: '123controller',
      quantity: "1",
      active: "1",
      discount_type: "percents",
      discount: 50,
      expiration: "2017-1-11"
    }
  }

  let(:invalid_attributes) {
    { description: 'Some description', 
      quantity: "1", 
      active: "1", 
      discount_type: "percents", 
      discount: 110, 
      expiration: "2017-1-11"
    }
  }

  let(:valid_session) { {} }

  describe "GET #show" do
    it "assigns the requested coupon as @coupon" do
      coupon = Coupon.create! valid_attributes
      get :show, {:id => coupon.to_param, :event_id => event.id}
      expect(assigns(:coupon)).to eq(coupon)
    end
  end

  describe "GET #new" do
    it "assigns a new coupon as @coupon" do
      get :new, {:event_id => event.id}
      expect(assigns(:coupon)).to be_a_new(Coupon)
    end
  end

  describe "GET #edit" do
    it "assigns the requested coupon as @coupon" do
      coupon = Coupon.create! valid_attributes
      get :edit, {:id => coupon.to_param, :event_id => event.id}
      expect(assigns(:coupon)).to eq(coupon)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Coupon" do
        expect {
          post :create, {:coupon => valid_attributes, :event_id => event.id}
        }.to change(Coupon, :count).by(1)
      end

      it "assigns a newly created coupon as @coupon" do
        post :create, {:coupon => valid_attributes, :event_id => event.id}
        expect(assigns(:coupon)).to be_a(Coupon)
        expect(assigns(:coupon)).to be_persisted
      end

      it "redirects to the created coupon" do
        post :create, {:coupon => valid_attributes, :event_id => event.id}
        expect(response).to redirect_to(events_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved coupon as @coupon" do
        post :create, {:coupon => invalid_attributes, :event_id => event.id}
        expect(assigns(:coupon)).to be_a_new(Coupon)
      end

      it "re-renders the 'new' template" do
        post :create, {:coupon => invalid_attributes, :event_id => event.id}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { description: 'Some description (updated)', 
          quantity: "10", 
          active: "1" 
        }
      }

      it "updates the requested coupon" do
        coupon = Coupon.create! valid_attributes
        put :update, {:id => coupon.to_param, :coupon => new_attributes, :event_id => event.id}
        coupon.reload
        expect(coupon.quantity).to eql 10
      end

      it "assigns the requested coupon as @coupon" do
        coupon = Coupon.create! valid_attributes
        put :update, {:id => coupon.to_param, :coupon => valid_attributes, :event_id => event.id}
        expect(assigns(:coupon)).to eq(coupon)
      end

      it "redirects to the coupon" do
        coupon = Coupon.create! valid_attributes
        put :update, {:id => coupon.to_param, :coupon => valid_attributes, :event_id => event.id}
        expect(response).to redirect_to(events_path)
      end
    end

    context "with invalid params" do
      it "assigns the coupon as @coupon" do
        coupon = Coupon.create! valid_attributes
        put :update, {:id => coupon.to_param, :coupon => invalid_attributes, :event_id => event.id}
        expect(assigns(:coupon)).to eq(coupon)
      end

      it "re-renders the 'edit' template" do
        coupon = Coupon.create! valid_attributes
        put :update, {:id => coupon.to_param, :coupon => invalid_attributes, :event_id => event.id}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested coupon" do
      coupon = Coupon.create! valid_attributes
      expect {
        delete :destroy, {:id => coupon.to_param, :event_id => event.id}
      }.to change(Coupon, :count).by(-1)
    end

    it "redirects to the coupons list" do
      coupon = Coupon.create! valid_attributes
      delete :destroy, {:id => coupon.to_param, :event_id => event.id}
      expect(response).to redirect_to(events_path)
    end
  end

end
