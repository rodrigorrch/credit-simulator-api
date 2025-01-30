require 'rails_helper'

RSpec.describe Domain::ValueObjects::InterestRate::Variable, type: :model do
  subject(:variable_rate) { described_class.new(base_rate: base_rate, spread: spread) }

  let(:base_rate) { 0.03 }
  let(:spread) { 0.02 }

  describe '#initialize' do
    it 'initializes with valid base rate and spread' do
      expect(variable_rate.base_rate).to eq(base_rate)
      expect(variable_rate.spread).to eq(spread)
      expect(variable_rate.value).to eq(base_rate + spread)
      expect(variable_rate.type).to eq('variable')
    end
  end

  describe '#calculate_for_period' do
    it 'calculates the interest rate for a given period' do
      months = 6
      expected_rate = base_rate + spread + (Math.sin(months / 12.0) * 0.01)
      expect(variable_rate.calculate_for_period(months)).to eq(expected_rate)
    end
  end

  describe '#fixed?' do
    it 'returns false' do
      expect(variable_rate.fixed?).to be false
    end
  end

  describe '#variable?' do
    it 'returns true' do
      expect(variable_rate.variable?).to be true
    end
  end

  describe '#annual_percentage' do
    it 'returns the annual percentage' do
      expect(variable_rate.annual_percentage).to eq((base_rate + spread) * 100)
    end
  end

  describe '#to_s' do
    it 'returns the string representation' do
      expect(variable_rate.to_s).to eq("#{format('%.2f', base_rate + spread)}% (variable)")
    end
  end

  describe '#to_decimal' do
    it 'returns the decimal value of the rate' do
      expect(variable_rate.to_decimal).to eq(base_rate + spread)
    end
  end
end
