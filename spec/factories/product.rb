FactoryBot.define do
  factory :product do
    name { Faker::Ancient.god }
    price { rand(900..10000) }
    category { Faker::Appliance.brand }
  end
end
