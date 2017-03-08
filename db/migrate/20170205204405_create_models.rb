class CreateModels < ActiveRecord::Migration[5.0]
  def change
    create_table :models do |t|
      t.string :name
      t.belongs_to :make, foreign_key: true
      t.string :slug
      t.index :slug

      t.timestamps
    end
  end
end
