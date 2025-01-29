module Domain
  module Services
    class InterestRateCalculator
      def calculate_for_age(birth_date)
        age = calculate_age(birth_date)

        case age
        when 0..25
          0.05
        when 26..40
          0.03
        when 41..60
          0.02
        else
          0.04
        end
      end

      private

      def calculate_age(birth_date)
        date = birth_date.is_a?(String) ? Date.parse(birth_date) : birth_date
        now = Date.current
        age = now.year - date.year
        age -= 1 if now.month < date.month || (now.month == date.month && now.day < date.day)
        age
      end
    end
  end
end
