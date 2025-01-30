module Application
  module UseCases
    class CreateBulkSimulation
      def execute(simulations_params)
        simulations_params.each do |params|
          Infrastructure::Queue::RabbitmqPublisher.publish('simulations.queue', params.to_json)
        end
      end
    end
  end
end
