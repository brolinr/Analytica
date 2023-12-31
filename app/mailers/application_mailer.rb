# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('DELIVERY_SUPPORT_EMAIL', nil)
  layout 'mailer'
end
