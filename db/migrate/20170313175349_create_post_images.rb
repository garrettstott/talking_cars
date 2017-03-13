class CreatePostImages < ActiveRecord::Migration[5.0]
  def change
    create_table :post_images do |t|
      t.belongs_to :post, foreign_key: true
      t.belongs_to :reply, foreign_key: true
      t.string :image 
      
      t.timestamps
    end
  end
end
