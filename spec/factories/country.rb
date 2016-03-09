FactoryGirl.define do

  factory :country do
    name { Faker::Address.country }
    code { Faker::Address.country_code }
    visited false
  end

  trait :visited do
    currencies { create_list(:currency, 1) }
    visited true
  end

end