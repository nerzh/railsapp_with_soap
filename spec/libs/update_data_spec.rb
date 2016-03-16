require 'rails_helper'
require_relative "../../lib/soap/update_data"

class TestModuleUpdateData
end

describe TestModuleUpdateData, type: :lib do
  include UpdateData

  context 'connect to WSDL' do
    it "connect class Savon::Client" do
      client = connect
      expect(client.class).to eq(Savon::Client)
    end
  end

  context 'response from client' do
    it "response class Savon::Response" do
      response = get_response(:get_currencies)
      expect(response.class).to eq(Savon::Response)
    end
  end

  context 'get the array of hashes countries' do
    it "hash" do
      response = get_countries
      expect(response.class).to eq(Array)
      expect(response[0].class).to eq(Hash)
      expect(response[0].empty?).to_not eq(true)
    end
  end

  context 'get the array of hashes currencies' do
    it "hash" do
      response = get_currencies
      expect(response.class).to eq(Array)
      expect(response[0].class).to eq(Hash)
      expect(response[0].empty?).to_not eq(true)
    end
  end

  context 'to make sql string' do
    it "sql query string" do
      table_name = :table
      attributes = ['attr1', 'attr2', 'attr3']
      values     = '(("val1", "val2", "val3"), ("val4", "val5", "val6"))'
      string = make_sql_query_string(table_name, attributes, values)
      got_string = "INSERT INTO table(attr1, attr2, attr3, created_at, updated_at) VALUES ((\"val1\", \"val2\", \"val3\"), (\"val4\", \"val5\", \"val6\"))"
      expect(string).to eq(got_string)
    end
  end

  it " replace ' to '' in array [[..],[..]] " do
    array = [["zzzz'zz"],["'zzzz'"],["zz''zz"]]
    unescape_value(array)
    expect(array).to eq([["zzzz''zz"],["''zzzz''"],["zz''''zz"]])
  end

  context 'clear array [[..],[..]]' do
    it "delete nil in array [[..],[..]] " do
      array = [["zzz"],["nil"],[nil]]
      clear_array(array)
      expect(array).to eq([["zzz"],["nil"]])
    end

    it "delete spaces in array [[..],[..]] " do
      array = [[" zzz "],["n1l "],[" nil"],[" n i l "]]
      clear_array(array)
      expect(array).to eq([["zzz"],["n1l"],["nil"],["n i l"]])
    end

    it "values must be uniq in array [[..],[..]] " do
      array = [["zzz"],["nil"],["zzz"]]
      clear_array(array)
      expect(array).to eq([["zzz"],["nil"]])
    end
  end

  context 'array in to string of values' do
    before :each do
      allow(Time).to receive(:now).and_return('time')
    end

    it "array [[..],[..]]" do
      array  = [["val1", "val2", "val3"], ["val4", "val5", "val6"]]
      got_string = "('val1', 'val2', 'val3', 'time', 'time'), ('val4', 'val5', 'val6', 'time', 'time')"
      string = sql_values(array)
      expect(string).to eq(got_string)
    end

    it "array [..]" do
      array  = ["val1", "val2", "val3"]
      got_string = "('val1', 'time', 'time'), ('val2', 'time', 'time'), ('val3', 'time', 'time')"
      string = sql_values(array)
      expect(string).to eq(got_string)
    end
  end

  context 'insert_array_with_sql' do
    it "check receive methods" do
      expect(self).to receive(:del_double).and_return(true)
      expect(self).to receive(:unescape_value).and_return(true)
      expect(self).to receive(:sql_values).and_return(true)
      expect(self).to receive(:execute_sql).and_return(true)
      insert_array_with_sql(1,2,3)
    end
  end

  context 'get_base_values' do
    it "make different the hashes of base" do
      soap_hash    = {'val'=> 'attr', 'val2'=> 'attr2', 'val3'=> 'attr3', 'val4'=> 'attr4'}
      output_hash  = Hash.new{ |hash, key| hash[key] = [] }
      key_name     = 'new_hash'
      key_name2    = 'new_hash2'
      get_base_values(soap_hash, output_hash, key_name, 'val',  'val2')
      get_base_values(soap_hash, output_hash, key_name2, 'val3', 'val4')
      expect(output_hash[:new_hash][0]).to  eq(['attr', 'attr2'])
      expect(output_hash[:new_hash2][0]).to eq(['attr3', 'attr4'])
    end
  end

  context 'del_double' do
    it "removes duplicates of code from array [[..],[..]]" do
      array    = [[3,45],[nil, 'code'],['attr','code'],[nil,45],['attr','attr']]
      expect(del_double(array)).to eq([[3, 45], [nil, "code"], ["attr", "attr"]])
    end
  end

end