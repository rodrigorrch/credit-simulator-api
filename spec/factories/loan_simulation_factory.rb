FactoryBot.define do
  factory :loan_simulation, class: 'Domain::Entities::LoanSimulation' do
    amount { 1000.0 }
    birth_date { Date.today }
    installments { 12 }
    interest_rate { 5.0 }
    currency { 'BRL' }

    trait :long_term do
      installments { 60 }
    end

    trait :low_amount do
      amount { 500.0 }
    end

    trait :high_interest do
      interest_rate { 15.0 }
    end
  end
end
