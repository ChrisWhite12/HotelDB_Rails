class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :fname
      t.string :lname
      t.string :role
      t.integer :phone
      t.references :payment, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
