require 'spec_helper'
require_relative '../../../app/domain/value_objects/money'

RSpec.describe Domain::ValueObjects::Money do
  subject(:money) { described_class.new(100, 'BRL') }

  let(:other_money) { described_class.new(50, 'BRL') }
  let(:different_currency_money) { described_class.new(50, 'USD') }

  describe '#initialize' do
    it 'sets the amount and currency' do
      expect(money.amount).to eq(100)
      expect(money.currency).to eq('BRL')
    end

    it 'raises an error for non-numeric amount' do
      expect { described_class.new('abc', 'BRL') }.to raise_error(ArgumentError, 'Valor deve ser numérico')
    end

    it 'raises an error for non-positive amount' do
      expect { described_class.new(-100, 'BRL') }.to raise_error(ArgumentError, 'Valor deve ser maior que zero')
    end
  end

  describe '#+' do
    it 'adds two Money objects with the same currency' do
      result = money + other_money
      expect(result.amount).to eq(150)
      expect(result.currency).to eq('BRL')
    end

    it 'raises an error for different currencies' do
      expect do
        money + different_currency_money
      end.to raise_error(ArgumentError, 'Moedas diferentes não podem ser operadas')
    end
  end

  describe '#-' do
    it 'subtracts two Money objects with the same currency' do
      result = money - other_money
      expect(result.amount).to eq(50)
      expect(result.currency).to eq('BRL')
    end

    it 'raises an error for different currencies' do
      expect do
        money - different_currency_money
      end.to raise_error(ArgumentError, 'Moedas diferentes não podem ser operadas')
    end
  end

  describe '#*' do
    it 'multiplies the amount by a number' do
      result = money * 2
      expect(result.amount).to eq(200)
      expect(result.currency).to eq('BRL')
    end
  end

  describe '#to_decimal' do
    it 'returns the amount as a decimal' do
      expect(money.to_decimal).to eq(100)
    end
  end
end
