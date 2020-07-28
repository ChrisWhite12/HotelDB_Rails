class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :card_no
      t.string :card_name
      t.integer :CSV
      t.date :expiry

      t.timestamps
    end
  end
end
