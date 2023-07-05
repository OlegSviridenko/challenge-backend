FactoryBot.define do
  factory :discount, class: Discount do
    condition { "#{Discount::COUNT_VARIABLE} if #{Discount::COUNT_VARIABLE} < 10" }
  end
end
