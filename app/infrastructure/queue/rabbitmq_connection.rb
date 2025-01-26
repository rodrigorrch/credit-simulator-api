module Infrastructure
  module Queue
    class RabbitmqConnection
      class << self
        def connection
          @connection ||= begin
            conn = Bunny.new(connection_config)
            conn.start
            conn
          end
        end

        def channel
          @channel ||= connection.create_channel
        end

        private

        def connection_config
          {
            host: ENV['RABBITMQ_HOST'] || 'rabbitmq',
            port: ENV['RABBITMQ_PORT'] || 5672,
            username: ENV['RABBITMQ_USER'] || 'guest',
            password: ENV['RABBITMQ_PASS'] || 'guest',
            vhost: ENV['RABBITMQ_VHOST'] || '/',
            automatically_recover: true
          }
        end
      end
    end
  end
end
