class AddActiveToCar < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :active, :string
  end
end
