class CreateForums < ActiveRecord::Migration[5.0]
  def change
    create_table :forums do |t|
      t.belongs_to :model, foreign_key: true
      t.string :name
      t.string :description
      t.string :category

      t.timestamps
    end
  end
end
