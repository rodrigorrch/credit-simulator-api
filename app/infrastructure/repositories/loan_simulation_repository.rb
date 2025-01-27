require_relative '../persistence/active_record/models/loan_simulation'

module Infrastructure
  module Repositories
    class LoanSimulationRepository
      def create(simulation)
        record = Infrastructure::Persistence::ActiveRecord::LoanSimulation.create!(
          to_record_attributes(simulation)
        )

        simulation.tap { |s| s.instance_variable_set(:@id, record.id) }
      end

      private

      def to_record_attributes(simulation)
        {
          amount: simulation.amount.to_decimal,
          birth_date: simulation.birth_date,
          installments: simulation.installments,
          interest_rate: simulation.interest_rate.value,
          rate_type: simulation.interest_rate.type.to_s,
          currency: simulation.currency,
          monthly_payment: simulation.monthly_payment.to_decimal,
          total_amount: simulation.total_amount.to_decimal
        }
      end
    end
  end
end