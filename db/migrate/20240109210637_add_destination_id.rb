class AddDestinationId < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :destination_id, :integer
  end
end
