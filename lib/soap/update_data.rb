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

    def make_sql_query_string(model, attr, values)
      "INSERT INTO #{model.to_s}(#{attr.join(', ')}, created_at, updated_at) VALUES #{values}"
    end

    def execute_sql(model, attr, values)
      return if values.empty?
      sql = make_sql_query_string(model, attr, values)
      ActiveRecord::Base.connection.execute sql
    end

    def sql_values(array)
      time = Time.now
      if array[0].class == Array
        return array.map{ |val| "('" << val.join("', '") << "', '#{time}', '#{time}')"}.join(", ")
      end
      array.map{ |val| "('" << val << "', '#{time}', '#{time}')" }.join(", ")
    end

    def insert_array_with_sql(model, array, *attr)
      array = del_double(array)
      unescape_value(array)
      string_values = sql_values(array)
      execute_sql(model, attr, string_values)
    end

    def get_base_values(soap_hash, output_hash, key_name, *keys)
      output_hash[key_name.to_sym] << keys.map{ |val| soap_hash[val] }
    end

    def clear_array(array)
      array.delete_if { |arr| arr.include?(nil) }
      array.each{ |arr| arr.map! { |val| val.gsub(/^\s+|\s+$/, '') } }.uniq! or array
    end

    def unescape_value(array)
      array.each{ |arr| arr.map! { |val| val.gsub(/'/){%q('')} } }
    end

    def del_double(array)
      output_aray = []
      array.each { |arr| output_aray << arr unless output_aray.rassoc(arr[1]) }
      output_aray
    end

end