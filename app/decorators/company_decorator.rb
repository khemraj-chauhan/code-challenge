class CompanyDecorator < Draper::Decorator
  delegate_all

  def city_and_state
    city.present? && state.present? ? "#{city}, #{state}" : 'City, State'
  end
end
