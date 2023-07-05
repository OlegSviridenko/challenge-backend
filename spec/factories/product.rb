FactoryBot.define do
  factory :product, class: Product do
    name { Faker::Name.name }
    code { Faker::Alphanumeric.alpha(number: 5) }
    price { rand(1.0...100.0).round(2) }
  end
end
