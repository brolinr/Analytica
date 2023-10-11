# frozen_string_literal: true

FactoryBot.define do
  factory(:lot) do
    title { FFaker::Product.brand }
    quantity { FFaker::Number.number }
    asking_price { FFaker::Number.number * 100 }
    description { FFaker::Book.description }
    company { create(:company, :as_buyer) }
    location { company.location }
    auction { create(:auction, company: company, location: company.location) }
  end
end
