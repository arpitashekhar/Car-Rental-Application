class AddStyleToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :style, :string
  end
end
