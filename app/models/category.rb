# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title, presence: true
end
