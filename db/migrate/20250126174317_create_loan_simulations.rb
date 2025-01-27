class CreateLoanSimulations < ActiveRecord::Migration[8.0]
  def change
    create_table :loan_simulations do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :birth_date, null: false
      t.integer :installments, null: false
      t.decimal :interest_rate, precision: 5, scale: 4, null: false
      t.string :rate_type, null: false, default: 'fixed'
      t.string :currency, null: false, default: 'BRL'
      t.decimal :monthly_payment, precision: 10, scale: 2
      t.decimal :total_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
