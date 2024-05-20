class CreateUsuarios < ActiveRecord::Migration[7.1]
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.boolean :write

      t.timestamps
    end
  end
end
