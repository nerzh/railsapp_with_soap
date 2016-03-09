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

    new_values[:new_associations].each do |array|
      currency = Currency.find_by(name: array[2], code: array[3])
      country  = Country.find_by(name: array[0], code: array[1])
      country.currencies << currency unless currency.nil? or country.nil?
    end
  end

end

def get_new_values(currencies, hash_old_values)
  output_hash = Hash.new{ |hash, key| hash[key] = [] }
  base_hash   = Hash.new{ |hash, key| hash[key] = [] }
  currencies.each do |soap_hash|
    get_base_values(soap_hash, base_hash, 'country_values',     'Name',     'CountryCode')
    get_base_values(soap_hash, base_hash, 'currency_values',    'Currency', 'CurrencyCode')
    get_base_values(soap_hash, base_hash, 'association_values', 'Name',     'CountryCode',
                                                                'Currency', 'CurrencyCode')
  end
  output_hash[:new_countries]    = clear_array(base_hash[:country_values])     - hash_old_values[:old_countries]
  output_hash[:new_currencies]   = clear_array(base_hash[:currency_values])    - hash_old_values[:old_currencies]
  output_hash[:new_associations] = clear_array(base_hash[:association_values]) - hash_old_values[:old_associations]
  output_hash
end