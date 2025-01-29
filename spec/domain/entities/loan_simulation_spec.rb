require 'spec_helper'

RSpec.describe Domain::Entities::LoanSimulation do
  subject(:entity) { described_class.new(attributes) }

  let(:attributes) do
    {
      id: 1,
      amount: 1000,
      birth_date: '1990-01-01',
      installments: 12,
      interest_rate: 0.05,
      currency: 'BRL'
    }
  end

  describe '#initialize' do
    it 'initializes with correct attributes' do
      expect(entity.id).to eq(attributes[:id])
      expect(entity.amount.to_decimal).to eq(attributes[:amount])
      expect(entity.birth_date).to eq(attributes[:birth_date])
      expect(entity.installments).to eq(attributes[:installments])
      expect(entity.currency).to eq(attributes[:currency])
    end
  end

  describe '#calc_monthly_payment' do
    it 'calculates the monthly payment' do
      expect(entity.monthly_payment).to be_a(Domain::ValueObjects::Money)
    end
  end

  describe '#calc_total_amount' do
    it 'calculates the total amount' do
      expect(entity.total_amount).to be_a(Domain::ValueObjects::Money)
    end
  end
end
