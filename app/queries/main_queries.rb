class MainQueries

  def initialize(params)
    @params = params
    @currencies = Currency.includes(:countries).order(name: :asc)
  end

  def search
    actual_currency
    @currencies
  end

  def actual_currency
    @currencies = @currencies.where(countries: {visited: false}) if @params[:actual_currency].present?
  end

end