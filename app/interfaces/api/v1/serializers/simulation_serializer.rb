module Interfaces
  module Api
    module V1
      module Serializers
        class SimulationSerializer
          def initialize(simulation)
            @simulation = simulation
          end

          def as_json(*)
            {
              data: {
                id: @simulation.id,
                type: 'loan_simulation',
                attributes: {
                  amount: @simulation.amount,
                  monthly_payment: @simulation.monthly_payment,
                  total_amount: @simulation.total_amount,
                  installments: @simulation.installments,
                  interest_rate: @simulation.interest_rate,
                  currency: @simulation.currency
                }
              }
            }
          end
        end
      end
    end
  end
end
