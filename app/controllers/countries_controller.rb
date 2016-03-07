require_relative "concerns/utility"
class CountriesController < ApplicationController
  authorize_resource
  before_action :define_country, only: [:update]
  include ControllerUtility

  def update
    @country.update(countries_params)
    render json: hash_exist_currency(@country)
  end

  private

  def countries_params
    params.require(:country).permit(:visited)
  end

  def define_country
    @country = Country.find(params[:id])
  end

end
