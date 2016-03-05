class CreateCountriesCurrency < ActiveRecord::Migration
  def change
    create_table :countries_currencies do |t|
      t.integer :country_id
      t.integer :currency_id

      t.timestamps null: false
    end
  end
end
