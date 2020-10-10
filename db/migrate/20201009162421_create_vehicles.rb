class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.integer :mileage
      t.string :location
      t.string :service_scheduled
      t.string :condition

      t.timestamps
    end
  end
end
