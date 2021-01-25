# Custom validation for company, currenty added email validation
class CompanyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless attributes.include?(:email)
    return if value.ends_with?('@getmainstreet.com')

    record.errors.add attribute, I18n.t('companies.validation.email_error')
  end
end
