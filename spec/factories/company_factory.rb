# frozen_string_literal: true

FactoryBot.define do
  pdf_path = Rails.root.join('spec/factories/media/documents/test.pdf')
  factory(:company) do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    name {  FFaker::Company.name }
    phone { FFaker::PhoneNumberAU.international_mobile_phone_number }
    location { FFaker::Address.city }
    address { FFaker::AddressBR.street_address }
    terms_and_conditions { true }
    tax_clearance { Rack::Test::UploadedFile.new(Rails.root.join(pdf_path), 'application/pdf') }
    certificate_of_incorporation { Rack::Test::UploadedFile.new(Rails.root.join(pdf_path), 'application/pdf') }
    cr5 { Rack::Test::UploadedFile.new(Rails.root.join(pdf_path), 'application/pdf') }
    cr6 { Rack::Test::UploadedFile.new(Rails.root.join(pdf_path), 'application/pdf') }
    confirmed_at { Time.zone.now }

    trait :as_seller do
      seller { true }
    end

    trait :as_buyer do
      buyer { true }
    end
  end
end
