class CompaniesController < ApplicationController
  include CompaniesHelper

  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      render :edit
    end
  end  

  def destroy
    @company.destroy!

    redirect_to companies_path, flash: { success: delete_message('success') }
  rescue StandardError => e
    Rails.logger.error("Company deleting error: #{e.backtrace}")
    redirect_to companies_path, flash: { error: e.message }
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :description,
      :zip_code,
      :phone,
      :email,
      :color,
      services: []
    )
  end

  def set_company
    @company = Company.find(params[:id]).decorate
  end
end
