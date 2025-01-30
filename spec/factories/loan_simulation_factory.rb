FactoryBot.define do
  factory :loan_simulation, class: 'Infrastructure::Persistence::ActiveRecord::LoanSimulation' do
    id { Faker::Number.number(digits: 10) }
    installments { Faker::Number.between(from: 1, to: 12) }
    amount { Faker::Number.decimal(l_digits: 4) }
    interest_rate { Faker::Number.decimal(l_digits: 0) }
    rate_type { 'fixed' }
    currency { 'BRL' }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    monthly_payment { amount / installments }
    total_amount { amount * installments }
  end
end
