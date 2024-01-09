class RemoveCityColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :destinations, :city
  end
end
