require 'rails_helper'

describe CurrenciesController, type: :controller do

  login_user
  let!(:user) { create(:user) }

  context 'test receive ability' do
    it { allow_any_instance_of(ApplicationController).to receive(:current_ability) }
  end

end