# frozen_string_literal: true

FactoryBot.define do
  factory :application, class: 'Application' do
    sequence(:name) { |n| "Project #{n}" }
    redirect_uri { 'http://localhost:3000' }
  end
end
