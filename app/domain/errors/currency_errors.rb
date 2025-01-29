module Domain
  module Errors
    class CurrencyError < ValidationError
      def initialize(message = nil)
        super(message, :currency)
      end
    end

    class InvalidCurrencyError < CurrencyError
      def initialize(currency)
        super("Moeda inválida: #{currency}")
      end
    end

    class CurrencyMismatchError < CurrencyError
      def initialize
        super('Operação não permitida entre moedas diferentes')
      end
    end

    class CurrencyConversionError < CurrencyError
      def initialize(from_currency, to_currency)
        super("Não foi possível converter de #{from_currency} para #{to_currency}")
      end
    end
  end
end
