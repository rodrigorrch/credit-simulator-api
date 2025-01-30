require 'rails_helper'

RSpec.describe Api::V1::Controllers::LoanSimulationsController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) do
      {
        loan_simulation: {
          amount: 10_000,
          birth_date: '1990-01-01',
          currency: 'BRL',
          installments: 12,
          notification_email: 'test@example.com',
          spread: 0.02
        }
      }
    end

    let(:invalid_params) do
      {
        loan_simulation: {
          amount: -10_000,
          birth_date: '1990-01-01',
          currency: 'BRL',
          installments: 12,
          notification_email: 'test@example.com',
          spread: 0.02
        }
      }
    end

    let(:create_loan_simulation) { instance_double(Application::UseCases::CreateLoanSimulation) }

    before do
      allow(Application::UseCases::CreateLoanSimulation).to receive(:new).and_return(create_loan_simulation)
    end

    context 'with valid params' do
      it 'creates a new loan simulation and returns created status' do
        allow(create_loan_simulation).to receive(:execute).and_return(double('LoanSimulation'))

        post :create, params: valid_params

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to be_present
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        allow(create_loan_simulation).to receive(:execute).and_raise(Domain::Errors::ValidationError,
                                                                     'Invalid parameters')

        post :create, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq('error' => 'Invalid parameters')
      end
    end
  end
end
