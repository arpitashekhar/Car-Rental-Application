class AddModelToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :model, :string
  end
end
