module ControllerUtility
  extend ActiveSupport::Concern

  def hash_exist_currency(country)
    { ids: country.currencies.where(exist: true).pluck(:id) }
  end
end