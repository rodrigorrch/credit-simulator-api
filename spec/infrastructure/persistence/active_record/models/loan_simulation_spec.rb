require 'rails_helper'

RSpec.describe Infrastructure::Persistence::ActiveRecord::LoanSimulation, type: :model do
  subject(:entitie) do
    described_class.new(
      amount: 1000,
      birth_date: '1990-01-01',
      installments: 12,
      interest_rate: 5.0,
      rate_type: 'fixed',
      currency: 'USD',
      monthly_payment: 100,
      total_amount: 1200
    )
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }

    it { is_expected.to validate_presence_of(:birth_date) }

    it { is_expected.to validate_presence_of(:installments) }
    it { is_expected.to validate_numericality_of(:installments).is_greater_than(0) }

    it { is_expected.to validate_presence_of(:interest_rate) }
    it { is_expected.to validate_numericality_of(:interest_rate).is_greater_than(0) }

    it { is_expected.to validate_presence_of(:rate_type) }
    it { is_expected.to validate_inclusion_of(:rate_type).in_array(%w[fixed variable]) }

    it { is_expected.to validate_presence_of(:currency) }

    it { is_expected.to validate_presence_of(:monthly_payment) }
    it { is_expected.to validate_numericality_of(:monthly_payment).is_greater_than(0) }

    it { is_expected.to validate_presence_of(:total_amount) }
    it { is_expected.to validate_numericality_of(:total_amount).is_greater_than(0) }
  end

  describe '#fixed?' do
    it 'returns true if rate_type is fixed' do
      entitie.rate_type = 'fixed'
      expect(entitie.fixed?).to be true
    end

    it 'returns false if rate_type is variable' do
      entitie.rate_type = 'variable'
      expect(entitie.fixed?).to be false
    end
  end

  describe '#variable?' do
    it 'returns true if rate_type is variable' do
      entitie.rate_type = 'variable'
      expect(entitie.variable?).to be true
    end

    it 'returns false if rate_type is fixed' do
      entitie.rate_type = 'fixed'
      expect(entitie.variable?).to be false
    end
  end
end
