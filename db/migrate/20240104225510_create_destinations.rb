class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.string :country
      t.string :city
      t.string :climate
      t.string :local_language
      t.integer :user_id

      t.timestamps
    end
  end
end
