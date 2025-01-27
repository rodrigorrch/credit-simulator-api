module Domain
  module ValueObjects
    class InterestRate
      class Variable < InterestRate
        attr_reader :base_rate, :spread

        def initialize(base_rate:, spread:)
          @base_rate = base_rate
          @spread = spread
          super(value: base_rate + spread, type: :variable)
        end

        def calculate_for_period(months)
          variation = Math.sin(months / 12.0) * 0.01
          @base_rate + @spread + variation
        end
      end
    end
  end
end