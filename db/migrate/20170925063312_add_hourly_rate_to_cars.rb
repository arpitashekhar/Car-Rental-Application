class AddHourlyRateToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :hourly_rate, :integer
  end
end
