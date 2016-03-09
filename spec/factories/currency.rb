FactoryGirl.define do

  factory :currency do
    name { Faker::Lorem.word }
    code { Faker::Address.state_abbr }
    exist false
  end

  trait :exist do
    countries { create_list( :country, Random.rand(1..5) ) }
    exist true
  end

end