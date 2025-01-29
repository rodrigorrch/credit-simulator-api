module Domain
  module Errors
    class DomainError < StandardError
      attr_reader :code

      def initialize(message = nil, code = nil)
        @code = code || self.class.name.demodulize.underscore
        super(message || self.class.name.demodulize.titleize.humanize)
      end
    end
  end
end
