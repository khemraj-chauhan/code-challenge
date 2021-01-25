require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) {FactoryBot.create(:company)}
  let(:company_lite) { FactoryBot.build_stubbed(:company) }

  describe '#color' do
    it { expect(company_lite).to have_db_column(:color).of_type(:string)
                             .with_options(default: '#00FF00') }
  end
  
  describe '#uniqueness of email' do
    it { should validate_uniqueness_of(:email) }
  end

  describe 'before_save #set_city_state' do
    let(:zip_code) { '30301' }
    let(:city) { 'Atlanta' }
    let(:state) { 'GA' }
    let(:non_existing_zipcode) {'341510'}

    context 'when new company object create' do
      context 'with zipcode' do
        it 'company object shoud have updated with city and state' do
          company = Company.create(zip_code: zip_code)

          expect(company.zip_code).to eq(zip_code)
          expect(company.city).to eq(city)
          expect(company.state).to eq(state)
        end
      end

      context 'without zipcode' do
        it 'company object shoud have updated with city and state' do
          company = Company.create

          expect(company.zip_code).to be_nil
          expect(company.city).to be_nil
          expect(company.state).to be_nil
        end
      end
    end

    context 'when existing company object update' do
      context 'company update the zipcode' do
        it 'company object shoud have updated with city and state' do
          expect(company.zip_code).to be_nil
          expect(company.city).to be_nil
          expect(company.state).to be_nil

          company.zip_code = zip_code
          company.save!

          expect(company.zip_code).to eq(zip_code)
          expect(company.city).to eq(city)
          expect(company.state).to eq(state)
        end
      end

      context 'company update the zipcode and zipcode address details not found in gem' do
        it 'city and state attributes will be empty' do
          expect(company.zip_code).to be_nil
          expect(company.city).to be_nil
          expect(company.state).to be_nil

          company.zip_code = non_existing_zipcode
          company.save!

          expect(company.zip_code).to eq(non_existing_zipcode)
          expect(company.city).to be_nil
          expect(company.state).to be_nil
        end
      end
    end
  end

  describe 'validate #email' do
    let(:email) { 'khemraj@getmainstreet.com' }

    context 'Company object create or update with email attributes' do
      context 'with null values' do
        it 'allow to update the email attributes' do
          expect(company).to be_present
          expect(company.email).to be_nil
        end
      end

      context 'with non valid email format' do
        it 'throw an error of invalid email' do
          company.email = Faker::Name.name

          expect(company).to_not be_valid
          expect(company.errors[:email]).to eq(["is invalid", "Invalid email, email should belongs to @getmainstreet.com domain"])
        end
      end

      context 'with valid email format but domain is not belongs to @getmainstreet.com' do
        it 'throw an error of invalid email' do
          company.email = Faker::Internet.safe_email

          expect(company).to_not be_valid
          expect(company.errors[:email]).to eq(["Invalid email, email should belongs to @getmainstreet.com domain"])
        end
      end

      context 'with valid email format and valid domain @getmainstreet.com' do
        it 'throw an error of invalid email' do
          company.email = email
          company.save!

          expect(company).to be_valid
          expect(company.email).to eq(email)
        end
      end
    end
  end
end
