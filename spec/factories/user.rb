FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
  end

  trait :admin do
    email 'admin@admin.admin'
  end

end