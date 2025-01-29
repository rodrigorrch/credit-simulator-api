require 'rails_helper'

RSpec.describe Application::UseCases::CreateLoanSimulation, type: :use_case do
  let(:loan_simulation_repository) { instance_double(Infrastructure::Repositories::LoanSimulationRepository) }
  let(:interest_rate_calculator) { instance_double(Domain::Services::InterestRateCalculator) }
  let(:use_case) do
    described_class.new(
      loan_simulation_repository: loan_simulation_repository,
      interest_rate_calculator: interest_rate_calculator
    )
  end

  describe '#execute' do
    let(:params) do
      {
        amount: 10_000,
        birth_date: Date.new(1980, 1, 1),
        installments: 12,
        type: :fixed
      }
    end

    before do
      allow(interest_rate_calculator).to receive(:calculate_for_age).with(params[:birth_date]).and_return(0.05)
      allow(loan_simulation_repository).to receive(:create)
    end

    it 'creates a loan simulation' do
      use_case.execute(params)

      expect(loan_simulation_repository).to have_received(:create)
    end

    context 'when params are invalid' do
      it 'raises a validation error if amount is missing' do
        params.delete(:amount)

        expect { use_case.execute(params) }.to raise_error(Domain::Errors::ValidationError, 'Valor é obrigatório')
      end

      it 'raises a validation error if birth_date is missing' do
        params.delete(:birth_date)

        expect do
          use_case.execute(params)
        end.to raise_error(Domain::Errors::ValidationError, 'Data de nascimento é obrigatória')
      end

      it 'raises a validation error if installments are missing' do
        params.delete(:installments)

        expect do
          use_case.execute(params)
        end.to raise_error(Domain::Errors::ValidationError, 'Número de parcelas é obrigatório')
      end
    end
  end
end
