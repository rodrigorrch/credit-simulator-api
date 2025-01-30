require 'rails_helper'

RSpec.describe Domain::ValueObjects::InterestRate::Fixed, type: :model do
  subject(:fixed_rate) { described_class.new(value: valid_rate) }

  let(:valid_rate) { 0.05 }

  describe '#initialize' do
    it 'initializes with a valid rate' do
      expect(fixed_rate.value).to eq(valid_rate)
      expect(fixed_rate.type).to eq('fixed')
    end
  end
end
