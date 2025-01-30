module Infrastructure
  module Queue
    class RabbitmqPublisher
      def self.publish(queue, message)
        channel = RabbitmqConnection.channel
        queue = channel.queue(queue, durable: true)

        channel.default_exchange.publish(message, routing_key: queue.name)
        connection.close
      end
    end
  end
end
