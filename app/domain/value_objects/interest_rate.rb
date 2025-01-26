module Domain
  module ValueObjects
    class InterestRate
      attr_reader :value

      def initialize(value)
        @value = validate_rate(value)
      end

      def monthly_rate
        value / 12.0
      end

      def to_decimal
        value
      end

      private

      def validate_rate(rate)
        raise ArgumentError, 'Taxa de juros deve ser maior que zero' unless rate.positive?
        raise ArgumentError, 'Taxa de juros deve ser menor que 100%' if rate > 1.0

        rate
      end
    end
  end
end
