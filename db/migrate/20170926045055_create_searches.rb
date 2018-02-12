class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :name
      t.string :style
      t.string :location
      t.string :carstatus

      t.timestamps
    end
  end
end
