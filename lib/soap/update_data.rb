module UpdateData

    def connect
      Savon.client(wsdl: "http://www.webservicex.net/country.asmx?WSDL")
    end

    def get_response(option)
      connect.call(option)
    end

    def get_currencies
      Nori.new.parse( get_response(:get_currencies)
          .body[:get_currencies_response][:get_currencies_result] )['NewDataSet']['Table']
    end

    def get_countries
      Nori.new.parse( get_response(:get_countries)
          .body[:get_countries_response][:get_countries_result] )['NewDataSet']['Table']
    end

    def execute_sql(model, attr, values)
      return if values.empty?
      sql = "INSERT INTO #{model}(#{attr.join(',')}, created_at, updated_at) VALUES #{values}"
      ActiveRecord::Base.connection.execute sql
    end

    def sql_values(array)
      time = Time.now
      if array[0].class == Array
        return array.map{ |val| "('" << val.join("','") << "','#{time}','#{time}')"}.join(",")
      end
      array.map{ |val| "('" << val << "','#{time}','#{time}')" }.join(",")
    end

    def insert_array_with_sql(model, array, *attr)
      clear_array(array)
      unescape_value(array)
      string_values = sql_values(array)
      execute_sql(model, attr, string_values)
    end

    def get_new_values(currencies, hash_old_values)
      output_hash = Hash.new{ |hash, key| hash[key] = [] }
      currencies.each do |hash|
        @country_values     = get_base_values(hash_old_values, output_hash, 'country_values',     'Name',     'CountryCode')
        @currency_values    = get_base_values(hash_old_values, output_hash, 'currency_values',    'Currency', 'CurrencyCode')
        @association_values = get_base_values(hash_old_values, output_hash, 'association_values', 'Name',     'CountryCode',
                                                                                                  'Currency', 'CurrencyCode')
      end
      output_hash[:new_countries]    = output_hash[:country_values]     - hash_old_values[:old_countries]
      output_hash[:new_currencies]   = output_hash[:currency_values]    - hash_old_values[:old_currencies]
      output_hash[:new_associations] = output_hash[:association_values] - hash_old_values[:old_associations]
      output_hash
    end

    def get_base_values(old_hash, output_hash, key_name, *keys)
      output_hash[key_name.to_sym] << keys.map{ |val| old_hash[val] }
    end

    def clear_array(array)
      array.delete_if { |arr| arr.include?(nil) }
    end

    def unescape_value(array)
      array.each{ |arr| arr.map! { |val| val.gsub(/'/){%q('')} } }
    end

end