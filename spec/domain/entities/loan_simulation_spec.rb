require 'rails_helper'

RSpec.describe Domain::Entities::LoanSimulation, type: :model do
  subject(:entitie) { described_class.new(attributes) }

  let(:attributes) do
    build('loan_simulation')
  end

  describe 'attributes' do
    it { is_expected.to have_attributes(id: attributes.id) }
    it { is_expected.to have_attributes(amount: an_instance_of(Domain::ValueObjects::Money)) }
    it { is_expected.to have_attributes(birth_date: attributes.birth_date) }
    it { is_expected.to have_attributes(installments: attributes[:installments]) }
    it { is_expected.to have_attributes(interest_rate: an_instance_of(Domain::ValueObjects::InterestRate::Fixed)) }
    it { is_expected.to have_attributes(currency: attributes.currency) }
    it { is_expected.to have_attributes(monthly_payment: an_instance_of(Domain::ValueObjects::Money)) }
    it { is_expected.to have_attributes(total_amount: an_instance_of(Domain::ValueObjects::Money)) }
  end

  describe '#calc_monthly_payment' do
    it 'calculates the monthly payment' do
      expect(entitie.send(:calc_monthly_payment)).to be_an_instance_of(Domain::ValueObjects::Money)
    end
  end

  describe '#calc_total_amount' do
    it 'calculates the total amount' do
      expect(entitie.send(:calc_total_amount)).to be_an_instance_of(Domain::ValueObjects::Money)
    end
  end
end
