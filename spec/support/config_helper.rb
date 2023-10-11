# frozen_string_literal: true

module ConfigHelper
  def stub_config(key, value, stub_restaurants: true, restaurant_id: nil)
    if restaurant_id.present?
      allow(::Config).to receive(:get_config).with(key,
                                                   restaurant_id: restaurant_id).and_return(value)
      return
    end

    allow(::Config).to receive(:get_config).with(key, anything).and_return(value) if stub_restaurants

    allow(::Config).to receive(:get_config).with(key).and_return(value)
  end
end
