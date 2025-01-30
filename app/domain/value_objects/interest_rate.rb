module Domain
  module ValueObjects
    class InterestRate
      include Comparable

      MAXIMUM_RATE = 1.0
      MINIMUM_RATE = 0.0001
      RATE_TYPES = %w[fixed variable].freeze

      attr_reader :value, :type

      def initialize(value:, type:)
        @value = BigDecimal(validate_rate(value), 4)
        @type = validate_type(type)
      end

      def monthly_rate
        value / BigDecimal('100')
      end

      def annual_percentage
        value * 100
      end

      def to_s
        "#{format('%.2f', value)}% (#{type})"
      end

      def <=>(other)
        return nil unless other.is_a?(InterestRate)

        value <=> other.value
      end

      def fixed?
        type == 'fixed'
      end

      def variable?
        type == 'variable'
      end

      def to_decimal
        value
      end

      private

      def validate_rate(rate)
        raise Errors::NegativeInterestRateError if rate.negative?
        raise Errors::InvalidInterestRateError unless rate.is_a?(Numeric)
        raise Errors::ExcessiveInterestRateError if rate >= MAXIMUM_RATE
        raise Errors::InvalidInterestRateError if rate < MINIMUM_RATE

        rate
      end

      def validate_type(type)
        type = type.to_s

        raise Errors::UnsupportedInterestRateTypeError type unless RATE_TYPES.include?(type)

        type
      end
    end
  end
end
