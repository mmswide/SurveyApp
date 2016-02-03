require 'rails_helper'

RSpec.describe WorkshopsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:day) { create(:day, event_id: event.id) }
  let(:room) { create(:room, day_id: day.id) }
  before(:each) do 
    log_in user
  end

  describe "GET #index" do
    before (:each) do
      get :index, room_id: room.id
    end
    it 'assigns current room to @room' do
      expect(assigns(:room)).to eq(room)
    end
    it 'assigns current event to @event' do
      expect(assigns(:event)).to eq(event)
    end
    it 'renders "index" template' do
      expect(response).to render_template('index')
    end
  end
  describe "GET #new" do
    before (:each) do
      xhr :get, :new, room_id: room.id, format: :js
    end
    it 'assigns new Workshop to @workshop' do
      expect(assigns(:workshop)).to be_a_new(Workshop)
    end
    it 'assigns room_id to @workshop' do
      expect(assigns(:workshop).room_id).to eq(room.id)
    end
    it 'renders js response' do
      expect(response.headers['Content-Type']).to match 'text/javascript'
    end
  end
  describe "POST #create" do
    before (:each) do |bfr|
      unless bfr.metadata[:skip_before]
        xhr :post, :create, room_id: room.id, workshop: attributes_for(:workshop, room_id: room.id), format: :js
      end
    end
    context 'valid attributes' do
      it 'assigns workshop atrributes to @workshop' do
        expect(assigns(:workshop).room_id).to eq(room.id)
      end
      it 'saves the object' do
        expect{
        xhr :post, :create, room_id: room.id, workshop: attributes_for(:workshop, room_id: room.id), format: :js
          }.to change(Workshop, :count).by(1)
      end
      it 'renders js response' do
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
    context 'unvalid attributes', :skip_before do
      it 'does not saves the object' do
        expect{
            xhr :post, :create, room_id: room.id, workshop: attributes_for(:workshop, title: nil), format: :js
          }.not_to change(Workshop, :count)
      end
      it 'renders js response' do
        xhr :post, :create, room_id: room.id, workshop: attributes_for(:workshop, title: nil), format: :js
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
  end
  describe "GET #edit" do
    let(:workshop) { create(:workshop, title: "bla", room_id: room.id) }
    before (:each) do
      xhr :get, :edit, id: workshop.id, format: :js
    end
    it 'renders js response' do
      expect(response.headers['Content-Type']).to match 'text/javascript'
    end
  end
  describe "PATCH #update" do
    let(:workshop) { create(:workshop, title: "bla", room_id: room.id) }
     before (:each) do |bfr|
      unless bfr.metadata[:skip_before]
        xhr :patch, :update, id: workshop.id, workshop: attributes_for(:workshop, title: "Na na na"), format: :js
      end
    end
    context 'valid attributes' do 
      it 'changes attributes' do
        workshop.reload
        expect(workshop.title).to eq("Na na na")
      end
      it 'renders js response' do
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
    context 'unvalid attributes', :skip_before do
      before(:each) do
        xhr :patch, :update, id: workshop.id, workshop: attributes_for(:workshop, title: nil), format: :js
      end
      it 'does not save changes' do
        workshop.reload
        expect(workshop.title).to eq("bla")
      end
      it 'renders js response' do
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
  end
  describe "GET #destroy" do
    it 'destroys the object' do
      workshop = create(:workshop, title: "bla", room_id: room.id)
      expect{
       xhr :delete, :destroy, id: workshop.id
      }.to change(Workshop, :count).by(-1)
    end
  end
end
