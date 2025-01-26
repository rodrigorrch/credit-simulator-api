module Infrastructure
  module Queue
    class RabbitmqConsumer
      def initialize
        @channel = RabbitmqConnection.channel
        setup_queues
      end

      def start_consuming
        @simulation_queue.subscribe(block: true) do |_delivery_info, _properties, payload|
          process_simulation(JSON.parse(payload))
        end
      end

      private

      def setup_queues
        @simulation_queue = @channel.queue('simulations.queue', durable: true)
        @simulation_queue.bind('simulations.exchange', routing_key: 'process_simulation')
      end

      def process_simulation(simulation_data)
        Application::UseCases::CreateLoanSimulation.new(
          loan_simulation_repository: Infrastructure::Repositories::LoanSimulationRepository.new,
          notification_service: Infrastructure::Services::NotificationService.new
        ).execute(simulation_data)
      end
    end
  end
end
