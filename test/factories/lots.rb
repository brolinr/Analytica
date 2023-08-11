FactoryBot.define do
  factory :lot do
    title { "MyString" }
    description { nil }
    quantity { 1 }
    asking_price { 1 }
    location { "MyString" }
    condition { "MyString" }
    company { nil }
    auction { nil }
  end
end
