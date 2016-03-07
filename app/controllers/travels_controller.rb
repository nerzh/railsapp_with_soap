require_relative "../../app/forms/travels_forms"
class TravelsController < ApplicationController
  authorize_resource

  def index
    @travels = Travel.all.order(id: :asc)
  end

  def new
    @travelForm = TravelForm.new
    @countries = Country.all.order(name: :asc)
  end

  def create
    return redirect_to travels_path if TravelForm.new.save(params)
    redirect_to new_travel_path
  end

  def update
    TravelForm.new.update(params)
    render json: {status: 200}
  end

end
