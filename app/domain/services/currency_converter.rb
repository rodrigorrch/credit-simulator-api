module Domain
  module Services
    class CurrencyConverter
      def convert(money, target_currency)
        return money if money.currency == target_currency

        conversion_rate = get_conversion_rate(money.currency, target_currency)
        new_amount = money.amount * conversion_rate
        
        ValueObjects::Money.new(
          amount: new_amount,
          currency: target_currency
        )
      end

      private

      def get_conversion_rate(from_currency, to_currency)
        # Em produção, isso poderia vir de uma API externa ou banco de dados
        conversion_rates = {
          'USD_BRL' => 5.0,
          'EUR_BRL' => 6.0,
          'BRL_USD' => 0.2,
          'BRL_EUR' => 0.17
        }

        key = "#{from_currency}_#{to_currency}"
        conversion_rates[key] || 1.0
      end
    end
  end
end 