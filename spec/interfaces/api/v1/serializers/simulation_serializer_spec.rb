require 'rails_helper'

RSpec.describe Interfaces::Api::V1::Serializers::SimulationSerializer, type: :serializer do
  subject(:serializer) { described_class.new(simulation) }

  let(:simulation) do
    double('LoanSimulation',
           id: 1,
           amount: 10_000,
           monthly_payment: 850,
           total_amount: 10_200,
           installments: 12,
           interest_rate: 0.05,
           currency: 'BRL')
  end

  describe '#as_json' do
    it 'returns the correct JSON structure' do
      expected_json = {
        data: {
          id: simulation.id,
          type: 'loan_simulation',
          attributes: {
            amount: simulation.amount,
            monthly_payment: simulation.monthly_payment,
            total_amount: simulation.total_amount,
            installments: simulation.installments,
            interest_rate: simulation.interest_rate,
            currency: simulation.currency
          }
        }
      }

      expect(serializer.as_json).to eq(expected_json)
    end
  end
end
