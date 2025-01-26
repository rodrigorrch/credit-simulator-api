module Infrastructure
  module Queue
    class RabbitmqPublisher
      def initialize
        @channel = RabbitmqConnection.channel
        setup_exchanges
      end

      def publish_simulation(simulation_data)
        @simulation_exchange.publish(
          simulation_data.to_json,
          routing_key: 'process_simulation',
          persistent: true
        )
      end

      private

      def setup_exchanges
        @simulation_exchange = @channel.direct('simulations.exchange', durable: true)
      end
    end
  end
end
