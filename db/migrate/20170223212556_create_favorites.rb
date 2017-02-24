class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.belongs_to :user, foreign_key: true
      t.string :favoritable_type
      t.string :favoritable_id

      t.timestamps
    end
  end
end
