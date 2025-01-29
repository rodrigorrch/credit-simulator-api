FactoryBot.define do
  factory :loan_simulation do
    amount { Faker::Number.decimal(l_digits: 2) }
    interest_rate { Faker::Number.decimal(l_digits: 2) }
    term { Faker::Number.between(from: 1, to: 30) }
    start_date { Faker::Date.forward(days: 23) }
  end
end
