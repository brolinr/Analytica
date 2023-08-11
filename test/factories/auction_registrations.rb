FactoryBot.define do
  factory :auction_registration do
    company { nil }
    auction { nil }
    company_approved { false }
  end
end
