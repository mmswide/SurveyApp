require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:day) { create(:day, event_id: event.id) }
  before(:each) do 
    log_in user
  end

  describe "GET #index" do
    before (:each) do
      get :index, event_id: event.id, day_id: day.id
    end
    it 'assigns current day to @day' do
      expect(assigns(:day)).to eq(day)
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
      xhr :get, :new, day_id: day.id, format: :js
    end
    it 'assigns new SubEvent to @sub_event' do
      expect(assigns(:room)).to be_a_new(Room)
    end
    it 'renders js response' do
      expect(response.headers['Content-Type']).to match 'text/javascript'
    end
  end
  describe "POST #create" do
    before (:each) do |bfr|
      unless bfr.metadata[:skip_before]
        xhr :post, :create, day_id: day.id, room: attributes_for(:room, day_id: day.id), format: :js
      end
    end
    context 'valid attributes' do
      it 'assigns room atrributes to @room' do
        expect(assigns(:room)).to be_an_instance_of(Room)
      end
      it 'sets @rooms day_id to id that comes from parameters' do
        expect(assigns(:room).day_id).to eq(day.id)
      end
      it 'saves the object' do
        expect{
          xhr :post, :create, day_id: day.id, room: attributes_for(:room, day_id: day.id), format: :js
          }.to change(Room, :count).by(1)
      end
      it 'renders js response' do
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
    context 'unvalid attributes', :skip_before do
      it 'does not saves the object' do
        expect{
          xhr :post, :create, day_id: day.id, room: attributes_for(:room, name: nil), format: :js
          }.not_to change(Room, :count)
      end
      it 'renders js response' do
        xhr :post, :create, day_id: day.id, room: attributes_for(:room, name: nil), format: :js
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
  end
  describe "GET #edit" do
    let(:room) { create(:room, name: "bla", day_id: day.id) }
    before (:each) do
      xhr :get, :edit, id: room.id, format: :js
    end
    it 'renders js response' do
      expect(response.headers['Content-Type']).to match 'text/javascript'
    end
  end
  describe "PATCH #update" do
    let(:room) { create(:room, name: "bla", day_id: day.id) }
     before (:each) do |bfr|
      unless bfr.metadata[:skip_before]
        xhr :patch, :update, id: room.id, room: attributes_for(:room, name: "Na na na"), format: :js
      end
    end
    context 'valid attributes' do 
      it 'changes attributes' do
        room.reload
        expect(room.name).to eq("Na na na")
      end
      it 'renders js response' do
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
    context 'unvalid attributes', :skip_before do
      before(:each) do
        xhr :patch, :update, id: room.id, room: attributes_for(:room, name: nil), format: :js
      end
      it 'does not save changes' do
        room.reload
        expect(room.name).to eq("bla")
      end
      it 'renders js response' do
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
  end
  describe "GET #destroy" do
    it 'destroys the object' do
      room = create(:room, name: "bla", day_id: day.id)
      expect{
       xhr :delete, :destroy, id: room.id
      }.to change(Room, :count).by(-1)
    end
  end
end
