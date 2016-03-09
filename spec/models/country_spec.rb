require 'rails_helper'
require 'cancan/matchers'

describe Country, type: :model do

  context 'associations' do
    it { should have_and_belong_to_many(:currencies) }
    it { should have_and_belong_to_many(:travels) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
  end

  context 'callbacks' do
    let(:model) { create(:country) }
    it "triggers currency_exist? on update" do
      expect(model).to receive(:currency_exist?)
      model.update(visited: true)
    end
  end

  context 'methods' do
    let(:model)  { create(:country, :visited) }
    let(:model2) { create(:country) }

    it 'must be change status false' do
      model.unvisited!
      expect(model.visited).to eq(false)
    end

    it 'must be change status true' do
      model2.visited!
      expect(model2.visited).to eq(true)
    end
  end

end