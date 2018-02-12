class AddCarstatusToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :carstatus, :string
  end
end
