class TravelForm

  include ActiveModel::Model
  include Virtus.model
  include Virtus::Multiparams

  def self.model_name
    ActiveModel::Name.new(self, nil, "Travel")
  end

  attr_reader :travel
  attribute :description,   String
  attribute :date,          DateTime
  attribute :complete_date, DateTime
  attribute :countries,     Array[String]

  validate :validation_model

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def update(params)
    Travel.find_by(id: params[:id])&.update!(travels_params(params))
  end

  def init(params)
    initialize(travels_params(params))
    get_countries
    hash_params = {description:   @description, date: @date,
                   complete_date: @complete_date,
                   countries:     @array_countries}
    @travel = Travel.new
    @travel.assign_attributes(hash_params)
    self
  end

  private

  def persist!
    @travel.save!(validate: false)
  end

  def get_countries
    @countries&.shift
    @array_countries = []
    country = nil
    @countries&.each do |i|
      @array_countries << country if country = Country.find_by(id: i.to_i)
    end
  end

  def travels_params(params)
    params.require(:travel).permit(:description, :date, :complete_date, countries: [])
  end

  def validation_model
    set_errors( @travel.errors ) unless @travel.valid?
  end

  def set_errors(model_errors)
    model_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end

end