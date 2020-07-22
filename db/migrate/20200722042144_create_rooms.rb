class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :price
      t.integer :no_people
      t.boolean :aval

      t.timestamps
    end
  end
end
