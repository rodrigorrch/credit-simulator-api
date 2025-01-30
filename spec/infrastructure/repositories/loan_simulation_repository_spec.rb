require 'rails_helper'

RSpec.describe Infrastructure::Repositories::LoanSimulationRepository, type: :repository do
  let(:record_class) { Infrastructure::Persistence::ActiveRecord::LoanSimulation }
  let(:repository) { described_class.new(record: record_class) }
  let(:attributes) do
    {
      amount: 10_000,
      birth_date: '1990-01-01',
      installments: 12,
      interest_rate: 0.05,
      rate_type: 'fixed',
      currency: 'BRL',
      monthly_payment: 850,
      total_amount: 10_200
    }
  end
  let(:domain_entity) { Domain::Entities::LoanSimulation.new(attributes) }

  describe '#create' do
    it 'creates a new loan simulation record' do
      result = repository.create(domain_entity)
      expect(result.id).not_to be_nil
      expect(record_class.find(result.id)).to be_present
    end
  end

  describe '#find' do
    it 'finds a loan simulation by id' do
      record = record_class.create!(attributes)
      result = repository.find(record.id)
      expect(result).to be_a(Domain::Entities::LoanSimulation)
      expect(result.id).to eq(record.id)
    end

    it 'returns nil if the loan simulation is not found' do
      result = repository.find(-1)
      expect(result).to be_nil
    end
  end

  describe '#first' do
    it 'returns the first loan simulation' do
      record = record_class.create!(attributes)
      result = repository.first
      expect(result).to be_a(Domain::Entities::LoanSimulation)
      expect(result.id).to eq(record.id)
    end
  end

  describe '#last' do
    it 'returns the last loan simulation' do
      record = record_class.create!(attributes)
      result = repository.last
      expect(result).to be_a(Domain::Entities::LoanSimulation)
      expect(result.id).to eq(record.id)
    end
  end

  describe '#where' do
    it 'returns loan simulations matching the conditions' do
      record = record_class.create!(attributes)
      results = repository.where(currency: 'BRL')
      expect(results).to all(be_a(Domain::Entities::LoanSimulation))
      expect(results.map(&:id)).to include(record.id)
    end
  end
end
