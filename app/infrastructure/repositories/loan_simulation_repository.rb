# app/infrastructure/repositories/loan_simulation_repository.rb
module Infrastructure
  module Repositories
    class LoanSimulationRepository
      def create(simulation)
        loan_simulation = LoanSimulation.create!(
          amount: simulation.amount.to_decimal,
          birth_date: simulation.birth_date,
          installments: simulation.installments,
          interest_rate: simulation.interest_rate.to_decimal,
          currency: simulation.amount.currency,
          monthly_payment: simulation.monthly_payment.to_decimal,
          total_amount: simulation.total_amount.to_decimal
        )
        map_to_entity(loan_simulation)
      end

      def find(id)
        loan_simulation = LoanSimulation.find_by(id: id)
        return nil unless loan_simulation

        map_to_entity(loan_simulation)
      end

      def create_bulk(simulations)
        loan_simulations = simulations.map do |simulation|
          {
            amount: simulation.amount.to_decimal,
            birth_date: simulation.birth_date,
            installments: simulation.installments,
            interest_rate: simulation.interest_rate.to_decimal,
            currency: simulation.amount.currency,
            monthly_payment: simulation.monthly_payment.to_decimal,
            total_amount: simulation.total_amount.to_decimal,
            created_at: Time.current,
            updated_at: Time.current
          }
        end

        LoanSimulation.insert_all(loan_simulations)
      end

      private

      def map_to_entity(record)
        Domain::Entities::LoanSimulation.new(
          amount: record.amount,
          birth_date: record.birth_date,
          installments: record.installments,
          interest_rate: record.interest_rate
        )
      end
    end
  end
end
