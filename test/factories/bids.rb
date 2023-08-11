FactoryBot.define do
  factory :bid do
    total_price { "MyString" }
    delivery_options { "MyText" }
    location { "MyString" }
    lot { nil }
    company { nil }
  end
end
