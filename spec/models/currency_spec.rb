require 'rails_helper'
require 'cancan/matchers'

describe Currency, type: :model do

  context 'associations' do
    it { should have_and_belong_to_many(:countries) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
  end

  context 'methods' do
    let(:model)  { create(:currency, :exist) }
    let(:model2) { create(:currency) }

    it 'must be change status false' do
      model.absent!
      expect(model.exist).to eq(false)
    end

    it 'must be change status true' do
      model2.exist!
      expect(model2.exist).to eq(true)
    end
  end

end