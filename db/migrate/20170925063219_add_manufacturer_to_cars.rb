class AddManufacturerToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :manufacturer, :string
  end
end
