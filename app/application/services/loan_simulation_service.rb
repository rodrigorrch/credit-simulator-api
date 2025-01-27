module Application
  module Services
    class LoanSimulationService
      def initialize(
        interest_rate_calculator: Domain::Services::InterestRateCalculator.new,
        currency_converter: Domain::Services::CurrencyConverter.new
      )
        @interest_rate_calculator = interest_rate_calculator
        @currency_converter = currency_converter
      end

      def calculate_loan_simulation(loan_amount:, currency:, birth_date:, payment_term:, rate_type: :fixed)
        money = ValueObjects::Money.new(amount: loan_amount, currency: currency)
        age = calculate_age(birth_date)
        
        interest_rate = case rate_type
                       when :fixed
                         create_fixed_rate(age)
                       when :variable
                         create_variable_rate(age)
                       end

        simulation = Domain::Entities::LoanSimulation.new(
          loan_amount: money,
          birth_date: birth_date,
          payment_term: payment_term,
          interest_rate: interest_rate
        )

        installments = simulation.calculate_installments

        Domain::ValueObjects::SimulationResult.new(
          installments: installments,
          interest_rate: interest_rate
        )
      end

      private

      def create_fixed_rate(age)
        base_rate = @interest_rate_calculator.calculate_for_age(age)
        ValueObjects::FixedInterestRate.new(base_rate)
      end

      def create_variable_rate(age)
        base_rate = @interest_rate_calculator.calculate_for_age(age)
        ValueObjects::VariableInterestRate.new(
          base_rate: base_rate,
          spread: 0.02 # 2% de spread
        )
      end
    end
  end
end 