def simulation_results(simulation)
  @simulation = simulation
  
  mail(
    to: @simulation.notification_email,
    subject: 'Your Loan Simulation Results'
  )
end