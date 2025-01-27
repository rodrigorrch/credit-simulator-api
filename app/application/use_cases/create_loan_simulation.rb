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

        @loan_simulation_repository.create(simulation)
      end

      private

      def validate_params(params)
        raise Domain::Errors::ValidationError.new("Valor é obrigatório") unless params[:amount]
        raise Domain::Errors::ValidationError.new("Data de nascimento é obrigatória") unless params[:birth_date]
        raise Domain::Errors::ValidationError.new("Número de parcelas é obrigatório") unless params[:installments]
      end
    end
  end
end
