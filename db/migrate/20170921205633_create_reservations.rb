class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.datetime :startdate
      t.datetime :enddate
      t.integer :carid
      t.integer :userid
      t.string :status
      t.timestamps
    end
  end
end
