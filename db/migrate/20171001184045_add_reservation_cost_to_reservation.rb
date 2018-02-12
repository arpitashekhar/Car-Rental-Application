class AddReservationCostToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :reservation_cost, :integer
  end
end
