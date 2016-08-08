class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :role
      t.string :address
      t.string :phone

      t.timestamps null: false
    end
  end
end
