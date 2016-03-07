class CreateCountriesTravels < ActiveRecord::Migration
  def change
    create_table :countries_travels do |t|
      t.integer :travel_id
      t.integer :country_id

      t.timestamps null: false
    end
  end
end
