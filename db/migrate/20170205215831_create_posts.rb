class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.belongs_to :forum, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :subject
      t.text :body
      t.string :slug
      t.index :slug
      t.integer :replies_count, default: 0

      t.timestamps
    end
  end
end
