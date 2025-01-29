module Domain
  module Errors
    class InterestRateError < ValidationError
      def initialize(message = nil)
        super(message, :interest_rate)
      end
    end

    class InvalidInterestRateError < InterestRateError
      def initialize(message = 'Taxa de juros inválida')
        super
      end
    end

    class NegativeInterestRateError < InterestRateError
      def initialize
        super('Taxa de juros não pode ser negativa')
      end
    end

    class ExcessiveInterestRateError < InterestRateError
      def initialize
        super('Taxa de juros excede o limite máximo permitido')
      end
    end

    class UnsupportedInterestRateTypeError < InterestRateError
      def initialize(type)
        super("Tipo de taxa de juros não suportado: #{type}")
      end
    end
  end
end
