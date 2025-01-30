module Application
  module UseCases
    class CreateLoanSimulation
      def initialize(klass = {})
        @loan_simulation_repository = klass[:loan_simulation_repository] || Infrastructure::Repositories::LoanSimulationRepository.new
        @interest_rate_calculator = klass[:interest_rate_calculator] || Domain::Services::InterestRateCalculator.new
      end

      def execute(params)
        validate_params(params)

        simulation = Domain::Entities::LoanSimulation.new({
                                                            amount: params[:amount],
                                                            birth_date: params[:birth_date],
                                                            installments: params[:installments],
                                                            interest_rate: @interest_rate_calculator.calculate_for_age(params[:birth_date]),
                                                            type: params[:type]
                                                          })

        process(@loan_simulation_repository.create(simulation))
      end

      private

      def validate_params(params)
        raise Domain::Errors::ValidationError, 'Valor é obrigatório' unless params[:amount]
        raise Domain::Errors::ValidationError, 'Data de nascimento é obrigatória' unless params[:birth_date]
        raise Domain::Errors::ValidationError, 'Número de parcelas é obrigatório' unless params[:installments]
      end

      def send_email(simulation_id)
        EmailWorker.perform_async(simulation_id)
      end

      def process(simulation)
        return {} unless simulation

        send_email(simulation.id)
        format(simulation)
      end

      def format(simulation)
        {
          data: {
            id: simulation.id,
            amount: simulation.amount.to_decimal,
            birth_date: simulation.birth_date,
            installments: simulation.installments
          },
          simulation: {
            interest_rate: simulation.interest_rate.to_decimal,
            currency: simulation.currency,
            monthly_payment: simulation.monthly_payment.to_decimal.round(2),
            total_amount: simulation.total_amount.to_decimal.round(2)
          }
        }
      end
    end
  end
end
