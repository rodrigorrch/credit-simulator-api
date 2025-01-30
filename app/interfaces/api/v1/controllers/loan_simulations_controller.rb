module Api
  module V1
    module Controllers
      class LoanSimulationsController < ::ApplicationController
        def create
          simulation = create_loan_simulation.execute(loan_simulation_params)

          render json: simulation, status: :created
        rescue Domain::Errors::ValidationError => e
          render json: { error: e.message }, status: :unprocessable_entity
        end

        def bulk
          create_bulk_simulation.execute(bulk_simulation_params[:simulations])

          render json: { message: 'Simulations are being processed' }, status: :accepted
        rescue StandardError => e
          render json: { error: e.message }, status: :unprocessable_entity
        end

        private

        def loan_simulation_params
          params.require(:loan_simulation).permit(:amount, :birth_date, :currency, :installments,
                                                  :notification_email, :spread)
        end

        def bulk_simulation_params
          params.require(:bulk_simulation).permit(simulations: [:amount, :birth_date, :currency, :installments,
                                                                :notification_email, :spread])
        end

        def create_loan_simulation
          @create_loan_simulation ||= Application::UseCases::CreateLoanSimulation.new(
            loan_simulation_repository: Infrastructure::Repositories::LoanSimulationRepository.new,
            interest_rate_calculator: Domain::Services::InterestRateCalculator.new
          )
        end

        def create_bulk_simulation
          @create_bulk_simulation ||= Application::UseCases::CreateBulkSimulation.new
        end
      end
    end
  end
end
