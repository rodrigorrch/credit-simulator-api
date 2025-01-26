module Domain
  module Entities
    class LoanSimulation
      attr_reader :amount, :birth_date, :installments, :interest_rate

      def initialize(amount:, birth_date:, installments:, interest_rate:)
        @amount = ValueObjects::Money.new(amount)
        @birth_date = birth_date
        @installments = installments
        @interest_rate = ValueObjects::InterestRate.new(interest_rate)
      end

      def monthly_payment
        pmt = calculate_pmt
        ValueObjects::Money.new(pmt, amount.currency)
      end

      def total_amount
        monthly_payment * installments
      end

      private

      def calculate_pmt
        r = interest_rate.monthly_rate
        pv = amount.to_decimal
        n = installments

        (pv * r * ((1 + r)**n)) / (((1 + r)**n) - 1)
      end
    end
  end
end
