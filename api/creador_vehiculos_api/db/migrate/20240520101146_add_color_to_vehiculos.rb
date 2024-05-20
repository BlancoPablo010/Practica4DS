class AddColorToVehiculos < ActiveRecord::Migration[7.1]
  def change
    add_column :vehiculos, :color, :string
  end
end
