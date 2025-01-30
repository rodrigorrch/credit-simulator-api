class AddNotificationEmailToLoanSimulations < ActiveRecord::Migration[8.0]
  def change
    add_column :loan_simulations, :notification_email, :string
  end
end
