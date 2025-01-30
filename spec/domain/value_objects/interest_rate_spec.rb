require 'rails_helper'

RSpec.describe Domain::ValueObjects::InterestRate, type: :model do
  let(:valid_rate) { 0.05 }
  let(:valid_type) { 'fixed' }
  let(:interest_rate) { described_class.new(value: valid_rate, type: valid_type) }

  describe '#initialize' do
    it 'initializes with valid attributes' do
      expect(interest_rate.value).to eq(valid_rate)
      expect(interest_rate.type).to eq(valid_type)
    end
  end

  describe '#annual_percentage' do
    it 'returns the annual percentage' do
      expect(interest_rate.annual_percentage).to eq(valid_rate * 100)
    end
  end

  describe '#to_s' do
    it 'returns the string representation' do
      expect(interest_rate.to_s).to eq("#{format('%.2f', valid_rate)}% (#{valid_type})")
    end
  end

  describe '#<=>' do
    it 'compares two interest rates' do
      other_rate = described_class.new(value: 0.03, type: valid_type)
      expect(interest_rate <=> other_rate).to eq(1)
    end
  end

  describe '#fixed?' do
    it 'returns true if the rate type is fixed' do
      expect(interest_rate.fixed?).to be true
    end
  end

  describe '#variable?' do
    it 'returns false if the rate type is not variable' do
      expect(interest_rate.variable?).to be false
    end
  end

  describe '#to_decimal' do
    it 'returns the decimal value of the rate' do
      expect(interest_rate.to_decimal).to eq(valid_rate)
    end
  end
end
