module Domain
  module Errors
    class ValidationError < DomainError
      attr_reader :field

      def initialize(message = nil, field = nil)
        @field = field
        super(message, 'validation_error')
      end
    end
  end
end
