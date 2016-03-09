require 'rails_helper'

describe CountriesController, type: :controller do

  login_user
  let!(:user) { create(:user) }

  context 'test receive ability' do
    it { allow_any_instance_of(ApplicationController).to receive(:current_ability) }
  end

  context 'callbacks' do
    it { should use_before_action(:define_country) }
  end

  describe 'PATCH #update' do
    let(:country) { create(:country) }

    it "response array in json" do
      patch :update, { id: country.id, country: {visited: true} }
      expect(json_response['ids'].class).to eq(Array)
    end
  end
end