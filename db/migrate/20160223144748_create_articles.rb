class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|

   	  t.string :title, :null => false
      t.integer :points 
      t.integer :comments 
      t.text :image_url 
      t.references :category

      t.timestamps
    end

    add_index :articles, :category_id
  end
end
