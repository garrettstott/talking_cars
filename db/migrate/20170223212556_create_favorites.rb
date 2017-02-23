class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :make_id
      t.integer :model_id
      t.integer :forum_id
      t.integer :post_id

      t.timestamps
    end
  end
end
