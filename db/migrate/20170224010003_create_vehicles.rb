class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.belongs_to :user, foreign_key: true
      t.string :make
      t.string :model
      t.string :year
      t.string :trim
      t.string :transmission
      t.string :engine
      t.string :exterior_color
      t.string :interior_color
      t.string :comments

      t.timestamps
    end
  end
end
