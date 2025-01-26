module Infrastructure
  module Workers
    class SimulationWorker
      include Sidekiq::Worker

      def perform(simulations_batch)
        publisher = Infrastructure::Queue::RabbitmqPublisher.new

        simulations_batch.each do |simulation|
          publisher.publish_simulation(simulation)
        end
      end
    end
  end
end
