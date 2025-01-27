module Domain
  module Errors
    class DateError < ValidationError
      def initialize(message = nil)
        super(message, :date)
      end
    end

    class InvalidBirthDateError < DateError
      def initialize
        super("Data de nascimento inválida")
      end
    end

    class FutureBirthDateError < DateError
      def initialize
        super("Data de nascimento não pode ser no futuro")
      end
    end

    class AgeLimitError < DateError
      def initialize(min_age, max_age)
        super("Idade deve estar entre #{min_age} e #{max_age} anos")
      end
    end
  end
end 