FactoryBot.define do
  factory :auction do
    title { "MyString" }
    description { nil }
    notes { "MyText" }
    location { "MyString" }
    start { "2023-08-10 07:51:51" }
    deadline { "2023-08-10 07:51:51" }
    company { nil }
  end
end
