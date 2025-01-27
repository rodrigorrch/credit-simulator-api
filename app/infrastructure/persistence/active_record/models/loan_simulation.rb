module Infrastructure
  module Persistence
    module ActiveRecord
      class LoanSimulation < ApplicationRecord
        self.table_name = 'loan_simulations'

        validates :amount, presence: true, numericality: { greater_than: 0 }
        validates :birth_date, presence: true
        validates :installments, presence: true, numericality: { greater_than: 0 }
        validates :interest_rate, presence: true, numericality: { greater_than: 0 }
        validates :rate_type, presence: true, inclusion: { in: %w[fixed variable] }
        validates :currency, presence: true
        validates :monthly_payment, presence: true, numericality: { greater_than: 0 }
        validates :total_amount, presence: true, numericality: { greater_than: 0 }

        def fixed?
          rate_type == 'fixed'
        end

        def variable?
          rate_type == 'variable'
        end
      end
    end
  end
end