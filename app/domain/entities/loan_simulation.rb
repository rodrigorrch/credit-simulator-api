module Domain
  module Entities
    class LoanSimulation
      attr_reader :id, :amount, :birth_date, :installments, :interest_rate,
                  :currency, :monthly_payment, :total_amount

      def initialize(attributes = {})
        @id = attributes[:id]
        @amount = Domain::ValueObjects::Money.new(attributes[:amount])
        @birth_date = attributes[:birth_date]
        @installments = attributes[:installments]
        @interest_rate = build_interest_rate(attributes[:interest_rate], attributes[:spread])
        @currency = attributes[:currency] || 'BRL'
        @monthly_payment = calc_monthly_payment
        @total_amount = calc_total_amount
      end

      private

      def build_interest_rate(rate, spread)
        return rate if rate.is_a?(ValueObjects::InterestRate)

        if spread.present?
          Domain::ValueObjects::InterestRate::Variable.new(
            base_rate: rate,
            spread: rate[:spread]
          )
        else
          Domain::ValueObjects::InterestRate::Fixed.new(
            value: rate
          )
        end
      end

      def calc_monthly_payment
        pmt = calculate_pmt
        ValueObjects::Money.new(pmt, amount.currency)
      end

      def calc_total_amount
        monthly_payment * installments
      end

      def calculate_pmt
        r = interest_rate.monthly_rate
        pv = amount.to_decimal
        n = installments

        numerador = pv * r
        denominador = 1 - ((1 + r)**-n)
        numerador / denominador
      end
    end
  end
end
