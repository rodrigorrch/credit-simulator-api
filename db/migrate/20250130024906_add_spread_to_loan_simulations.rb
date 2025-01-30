class AddSpreadToLoanSimulations < ActiveRecord::Migration[8.0]
  def change
    add_column :loan_simulations, :spread, :decimal, precision: 10, scale: 2
  end
end
