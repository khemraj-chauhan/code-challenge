require 'rails_helper'

RSpec.describe CompanyDecorator, type: :decorator do
  let(:company) { FactoryBot.build_stubbed(:company).decorate }
  let(:city) { Faker::Address.city }
  let(:state) { Faker::Address.state }
  let(:full_company) { FactoryBot.build_stubbed(:company, city: city, state: state).decorate }

  describe '#city_and_state' do
    let(:default_city_state) { 'City, State' }

    context 'company object have city and state' do
      it 'return company city and state name from DB' do
        expect(company.city_and_state).to eq(default_city_state)
      end
    end

    context 'company object do not have city and state' do
      it 'return company city and state as string' do
        expect(full_company.city_and_state).to eq("#{city}, #{state}")
      end
    end
  end
end
