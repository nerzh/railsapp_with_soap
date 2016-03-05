require_relative '../../lib/soap/update_data'

include UpdateData

namespace :soap do

  task update_data: :environment do
    currencies                    = get_currencies
    old_values                    = {}
    old_values[:old_countries]    = Country.all.pluck(:name, :code)
    old_values[:old_currencies]   = Currency.all.pluck(:name, :code)
    old_values[:old_associations] = CountriesCurrency.joins(:country, :currency).pluck(:'countries.name',  :'countries.code',

                                                                                       :'currencies.name', :'currencies.code')
    new_values = get_new_values(currencies, old_values)

    insert_array_with_sql('countries',  new_values[:new_countries],  'name', 'code')
    insert_array_with_sql('currencies', new_values[:new_currencies], 'name', 'code')

    clear_array( new_values[:new_associations] )
    new_values[:new_associations].each do |array|
      currency = Currency.find_by(name: array[2], code: array[3])
      country  = Country.find_by(name: array[0], code: array[1])
      country.currencies << currency unless currency.nil? or country.nil?
    end
  end

end