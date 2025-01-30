module Infrastructure
  module Repositories
    class LoanSimulationRepository
      def initialize(record: Infrastructure::Persistence::ActiveRecord::LoanSimulation)
        @record = record
      end

      def create(simulation)
        model = record.create!(
          to_record_attributes(simulation)
        )

        simulation.tap { |simulate| simulate.instance_variable_set(:@id, model.id) }
      end

      def find(id)
        model = record.find(id)
        to_domain_entity(model)
      rescue ActiveRecord::RecordNotFound
        nil
      end

      def first
        to_domain_entity(record.first)
      end

      def last
        to_domain_entity(record.last)
      end

      def where(conditions)
        models = record.where(conditions)
        models.map { |model| to_domain_entity(model) }
      end

      private

      attr_reader :record

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

      def to_domain_entity(record)
        Domain::Entities::LoanSimulation.new(
          id: record.id,
          amount: record.amount,
          birth_date: record.birth_date,
          installments: record.installments,
          interest_rate: record.interest_rate,
          currency: record.currency,
          monthly_payment: record.monthly_payment,
          total_amount: record.total_amount
        )
      end
    end
  end
end
