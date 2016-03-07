class AddCompleteDateToTravel < ActiveRecord::Migration
  def change
    add_column :travels, :complete_date, :datetime
  end
end
