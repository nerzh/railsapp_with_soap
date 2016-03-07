class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.string :description
      t.datetime :date

      t.timestamps null: false
    end
  end
end
