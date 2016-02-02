require 'rails_helper'

RSpec.describe SubEventsController, type: :controller do
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
    it 'assigns current event to @event' do
      expect(assigns(:event)).to eq(event)
    end
    it 'assigns current day to @day' do
      expect(assigns(:day)).to eq(day)
    end
    it 'renders "index" template' do
      expect(response).to render_template('index')
    end
  end
  describe "GET #new" do
    before (:each) do
      xhr :get, :new, event_id: event.id, day_id: day.id, format: :js
    end
    it 'assigns new SubEvent to @sub_event' do
      expect(assigns(:sub_event)).to be_a_new(SubEvent)
    end
    it 'renders js response' do
      expect(response.headers['Content-Type']).to match 'text/javascript'
    end
  end
  describe "POST #create" do
    before (:each) do |bfr|
      unless bfr.metadata[:skip_before]
        xhr :post, :create, event_id: event.id, day_id: day.id, sub_event: attributes_for(:sub_event, day_id: day.id), format: :js
      end
    end
    context 'valid attributes' do
      it 'assigns sub events atrributes to @sub_event' do
        expect(assigns(:sub_event)).to be_an_instance_of(SubEvent)
      end
      it 'sets @sub_events day_id to id that comes from parameters' do
        expect(assigns(:sub_event).day_id).to eq(day.id)
      end
      it 'saves the object' do
        expect{
          xhr :post, :create, event_id: event.id, day_id: day.id, sub_event: attributes_for(:sub_event), format: :js
          }.to change(SubEvent, :count).by(1)
      end
      it 'renders js response' do
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
    context 'unvalid attributes', :skip_before do
      it 'does not saves the object' do
        expect{
          xhr :post, :create, event_id: event.id, day_id: day.id, sub_event: attributes_for(:sub_event, hour: nil), format: :js
          }.not_to change(SubEvent, :count)
      end
      it 'renders js response' do
        xhr :post, :create, event_id: event.id, day_id: day.id, sub_event: attributes_for(:sub_event, hour: nil), format: :js
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
  end
  describe "GET #edit" do
    let(:sub_event) { create(:sub_event, description: "bla", day_id: day.id) }
    before (:each) do
      xhr :get, :edit, event_id: event.id, day_id: day.id, id: sub_event.id, format: :js
    end
    it 'renders js response' do
      expect(response.headers['Content-Type']).to match 'text/javascript'
    end
  end
  describe "PATCH #update" do
    let(:sub_event) { create(:sub_event, description: "bla", day_id: day.id) }
     before (:each) do |bfr|
      unless bfr.metadata[:skip_before]
        xhr :patch, :update, event_id: event.id, day_id: day.id, id: sub_event.id, sub_event: attributes_for(:sub_event, description: "Na na na"), format: :js
      end
    end
    context 'valid attributes' do 
      it 'changes attributes' do
        sub_event.reload
        expect(sub_event.description).to eq("Na na na")
      end
      it 'renders js response' do
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
    context 'unvalid attributes', :skip_before do
      before(:each) do
        xhr :patch, :update, event_id: event.id, day_id: day.id, id: sub_event.id, sub_event: attributes_for(:sub_event, description: nil), format: :js
      end
      it 'does not save changes' do
        sub_event.reload
        expect(sub_event.description).to eq("bla")
      end
      it 'renders js response' do
        expect(response.headers['Content-Type']).to match 'text/javascript'
      end
    end
  end
  describe "GET #destroy" do
    it 'destroys the object' do
      sub_event = create(:sub_event, description: "bla", day_id: day.id)
      expect{
       xhr :delete, :destroy,  event_id: event.id, day_id: day.id, id: sub_event.id
      }.to change(SubEvent, :count).by(-1)
    end
  end
end
