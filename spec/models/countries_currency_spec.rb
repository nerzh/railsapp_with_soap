require 'rails_helper'
require 'cancan/matchers'

describe CountriesCurrency, type: :model do

  context 'associations' do
    it { should belong_to(:currency) }
    it { should belong_to(:country) }
  end

end