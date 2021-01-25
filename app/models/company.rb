class Company < ApplicationRecord
  has_rich_text :description

  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true }
  validates :email, company: true, if: -> { email.present? }

  before_save :set_city_state

  private

  def set_city_state
    return if zip_code.blank?

    address = ZipCodes.identify(zip_code)
    return if address.blank?

    self.state = address[:state_code]
    self.city = address[:city]
  end
end
