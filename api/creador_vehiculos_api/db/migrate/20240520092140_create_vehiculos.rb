class CreateVehiculos < ActiveRecord::Migration[7.1]
  def change
    create_table :vehiculos do |t|
      t.string :motor
      t.string :ruedas
      t.string :carroceria
      t.string :personalizacion
      t.string :usuario

      t.timestamps
    end
  end
end
