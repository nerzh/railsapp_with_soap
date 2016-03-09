require 'rails_helper'
require 'cancan/matchers'

describe 'User' do
  describe 'abilities' do
    let(:user) { create(:user) }
    let(:guest) { nil }
    let(:country) { create(:country) }
    let(:currency) { create(:currency) }
    let(:travel) { create(:travel) }

    context 'user' do
      context 'can' do
        subject(:ability) { Ability.new(user) }

        it { expect(ability).to be_able_to(:manage, :all) }
      end
    end

    context 'guest' do
      subject(:ability) { Ability.new(guest) }

      context 'can' do
        it { expect(ability).to be_able_to(:read, :main) }
      end

      context 'cannot' do
        it { expect(ability).not_to be_able_to(:manage, country) }
        it { expect(ability).not_to be_able_to(:manage, currency) }
        it { expect(ability).not_to be_able_to(:manage, travel) }
      end
    end
  end
end