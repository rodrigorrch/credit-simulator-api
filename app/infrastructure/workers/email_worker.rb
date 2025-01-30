class EmailWorker
  include Sidekiq::Worker

  def perform(simulation_id)
    simulation = Domain::Entities::LoanSimulation.find(simulation_id)
    EmailService.new.send_simulation_results(simulation)
  end
end
