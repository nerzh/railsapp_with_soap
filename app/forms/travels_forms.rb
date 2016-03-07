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

  def persisted?
    false
  end

  def save(params)
    initialize(travels_params(params))
    if valid?
      persist!
      true
    else
      false
    end
  end

  def update(params)
    Travel.find_by(id: params[:id])&.update(travels_params(params))
  end

  private

  def persist!
    get_countries
    @travel = Travel.new(description:   @description, date: @date,
                         complete_date: @complete_date,
                         countries:     @array_countries ).save!(validate: false)
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

end