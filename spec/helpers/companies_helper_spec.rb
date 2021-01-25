require 'rails_helper'

RSpec.describe CompaniesHelper, type: :helper do
  let(:company) { FactoryBot.build_stubbed(:company) }

  describe '#delete_message' do
    context 'when message type send as arguments and company instance present' do
      it 'return full message' do
        assign(:company, company)
        expect(helper.delete_message('success')).to eq(t('companies.delete.success', company_name: company.name))
        expect(helper.delete_message('confirmation')).to eq(t('companies.delete.confirmation', company_name: company.name))
      end
    end

    context 'when message type send as arguments but company instance is not present' do
      context 'send company_name as arguments' do
        it 'return full message' do
          expect(helper.delete_message('success', company.name)).to eq(t('companies.delete.success', company_name: company.name))
          expect(helper.delete_message('confirmation', company.name)).to eq(t('companies.delete.confirmation', company_name: company.name))
        end
      end
    end
  end
end
