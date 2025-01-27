Rails.application.config.to_prepare do
  Infrastructure::Queue::RabbitmqInitializer.setup unless Rails.env.test?
rescue => e
  Rails.logger.error "Erro ao carregar RabbitMQ: #{e.message}"
end
