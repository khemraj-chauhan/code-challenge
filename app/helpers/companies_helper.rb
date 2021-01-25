module CompaniesHelper
  def delete_message(type, company_name = nil)
    t("companies.delete.#{type}", company_name: company_name || @company&.name)
  end
end
