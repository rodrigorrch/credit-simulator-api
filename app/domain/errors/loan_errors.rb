module Domain
  module Errors
    class LoanError < ValidationError
      def initialize(message = nil)
        super(message, :loan)
      end
    end

    class InvalidLoanAmountError < LoanError
      def initialize
        super('Valor do empréstimo inválido')
      end
    end

    class InvalidPaymentTermError < LoanError
      def initialize
        super('Prazo de pagamento inválido')
      end
    end

    class ExcessiveLoanAmountError < LoanError
      def initialize(max_amount)
        super("Valor do empréstimo excede o limite máximo de #{max_amount}")
      end
    end

    class MinimumLoanAmountError < LoanError
      def initialize(min_amount)
        super("Valor do empréstimo abaixo do mínimo de #{min_amount}")
      end
    end
  end
end
