module Domain
  module ValueObjects
    class Money
      attr_reader :amount, :currency

      def initialize(amount, currency = 'BRL')
        @amount = validate_amount(amount)
        @currency = currency
      end

      def +(other)
        validate_same_currency(other)
        Money.new(amount + other.amount, currency)
      end

      def -(other)
        validate_same_currency(other)
        Money.new(amount - other.amount, currency)
      end

      def *(other)
        Money.new(amount * other, currency)
      end

      def to_decimal
        amount
      end

      private

      def validate_amount(value)
        raise ArgumentError, 'Valor deve ser numérico' unless value.is_a?(Numeric)
        raise ArgumentError, 'Valor deve ser maior que zero' unless value.positive?

        value
      end

      def validate_same_currency(other)
        raise ArgumentError, 'Moedas diferentes não podem ser operadas' unless currency == other.currency
      end
    end
  end
end
