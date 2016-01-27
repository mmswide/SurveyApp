require 'rails_helper'

RSpec.describe OrderController, type: :controller do
  describe "GET #new" do
    context 'enough tickets' do
      it 'assigns new order to @order'
      it 'assigns new order with event_id'
      it 'builds entitlements for order'
      it 'renders new template'
    end
    context 'not enough tickets' do
      it 'redirects to back'
      it 'flashes warning'
    end
  end
  describe "POST #create" do
    context 'valid attributes' do
      it 'saves the order to the database'
      it 'redirects to users show page'
      it 'flashes success'
    end
    context 'unvalid attributes' do
      it "doesn't saves the order to the database"
      it 'renders new template'
      it 'flashes error'
    end
  end
  describe "GET #sign_up_user" do
    it 'waits for new logic to be merged into master'
  end
end
