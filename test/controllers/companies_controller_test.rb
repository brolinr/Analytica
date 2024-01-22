# frozen_string_literal: true

require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get companies_new_url
    assert_response :success
  end
end
