FactoryGirl.define do

  factory :travel do
    description { Faker::Lorem.sentence }
    date { Faker::Time.forward(2, :morning) }
    countries { create_list( :country, Random.rand(1..5) ) }
  end

  trait :completed do
    complete_date { Faker::Time.forward( Random.rand(2..10), :morning ) }
  end

end