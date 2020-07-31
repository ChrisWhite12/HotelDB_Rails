class RemoveBookingRefFromRooms < ActiveRecord::Migration[6.0]
  def change
    remove_reference :rooms, :booking, null: false, foreign_key: true
  end
end
