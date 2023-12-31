# frozen_string_literal: true

module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'Analytica'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def currency_format(price, currency = 'USD')
    Money.new(price, currency)
  end
end
