# frozen_string_literal: true

FactoryBot.define do
  factory(:auction) do
    title { "#{FFaker::Product.product_name} Auction" }
    location { FFaker::Address.city }
    description { FFaker::Book.description }
    start { Time.current }
    deadline { start + 5.days }

    trait(:with_company) do
      company { create(:company, :as_buyer) }
      location { company.location }
    end
  end
end
