require 'rails_helper'
require 'cancan/matchers'

describe Travel, type: :model do

  context 'associations' do
    it { should have_and_belong_to_many(:countries) }
  end

  context 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(255) }
  end

  context 'callbacks' do
    let(:model) { build(:travel) }
    it "triggers update_statuses on save" do
      expect(model).to receive(:update_statuses)
      model.save
    end
  end

  context 'methods' do
    let(:model)  { build(:travel, :completed) }
    let(:model2) { build(:travel) }

    it 'must be return status true' do
      expect(model.complete?).to eq(true)
    end

    it 'must be return status false' do
      expect(model2.complete?).to eq(false)
    end
  end

end