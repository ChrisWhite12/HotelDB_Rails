class AddBookingToRoom < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :booking, null: false, foreign_key: true
  end
end
