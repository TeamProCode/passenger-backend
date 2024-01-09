class AddImageColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :destinations, :image, :string
  end
end
