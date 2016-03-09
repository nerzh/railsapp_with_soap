require 'rails_helper'

describe MainController, type: :controller do

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

end