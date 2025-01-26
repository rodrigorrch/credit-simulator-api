module Infrastructure
  module Queue
    class RabbitmqInitializer
      def self.setup
        connection = RabbitmqConnection.connection
        channel = connection.create_channel

        # Configuração das filas
        exchange = channel.direct('simulations.exchange', durable: true)
        queue = channel.queue('simulations.queue', durable: true)
        queue.bind(exchange, routing_key: 'process_simulation')

        # Configuração da fila de notificações
        notification_exchange = channel.direct('notifications.exchange', durable: true)
        notification_queue = channel.queue('notifications.queue', durable: true)
        notification_queue.bind(notification_exchange, routing_key: 'send_notification')
      end
    end
  end
end
