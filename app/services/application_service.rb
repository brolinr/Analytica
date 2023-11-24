# frozen_string_literal: true

class ApplicationService
  attr_reader :params, :object

  def self.call(params: {}, object: {}, **args)
    new(params: params, object: object).call(**args)
  end

  def initialize(params: {}, object: {})
    @params = params
    @object = object
  end

  def call
    raise NotImplementedError, '#call method must be implemented'
  end
end
