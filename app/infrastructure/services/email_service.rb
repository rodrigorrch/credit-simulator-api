class EmailService
  def send_simulation_results(simulation)
    return if simulation&.notification_email.blank?

    # Mock de envio de email
    puts "Enviando email para #{simulation&.notification_email} com os resultados da simulação:"
    puts "Amount: #{simulation.amount}"
    puts "Monthly Payment: #{simulation.monthly_payment.round(2)}"
    puts "Total Amount: #{simulation.total_amount.round(2)}"
  end
end
