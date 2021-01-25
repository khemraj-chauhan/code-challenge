require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let(:company) {FactoryBot.create(:company)}

  describe 'DELETE #destroy' do
    context 'call company delete request' do
      it "returns a success response with valid company id in request" do
        expect(company.present?).to eq(true)

        delete :destroy, params: {id: company.id}
        
        expect(response).to redirect_to(companies_path)
        expect(flash[:success]).to be_present
        expect(flash[:success]).to eq( I18n.t('companies.delete.success', company_name: company.name))
      end

      it "returns a failure message when error occor" do
        allow_any_instance_of(CompaniesController).to receive(:set_company).and_return(nil)

        delete :destroy, params: {id: rand(1..100)}
        
        expect(response).to redirect_to(companies_path)
        expect(flash[:error]).to be_present
      end
    end
  end

  describe '#company_params' do
    context 'check permit params for POST create action' do
      it 'return true when params is permitted' do
        should permit(
          :name, :description, :zip_code, :phone, :email, :color, {:services => []}
        ).for(:create, params: {company: {
          name: 'khemraj chauhan', phone: '1111111111', color: '#00FF00', email: 'khemraj@example.com',
          description: 'Khemraj rspec test', zip_code: '341510',
          services: ["Interior Painting", "Exterior Painting"]
        }})
      end
    end
  end
end
