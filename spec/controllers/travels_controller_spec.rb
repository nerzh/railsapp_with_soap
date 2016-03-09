require 'rails_helper'

describe TravelsController, type: :controller do

  login_user
  let!(:user) { create(:user) }

  context 'test receive ability' do
    it { allow_any_instance_of(ApplicationController).to receive(:current_ability) }
  end

  describe 'GET #index' do
    it "response status 200" do
      get :index, {}
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #new' do
    it "response status 200" do
      get :new, {}
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    it "if form be save" do
      post :create, travel: {description: 'descr', date: Time.now, countries: []}
      should redirect_to(travels_path)
    end

    it "if form not save" do
      post :create, travel: {description: '', date: Time.now, countries: []}
      should redirect_to(new_travel_path)
    end
  end

  describe 'PATCH #update' do
    let(:travel) { create(:travel) }

    it "response status 200" do
      patch :update, { id: travel.id, travel: {complete_date: Time.now} }
      expect(response.status).to eq(200)
    end
  end
end