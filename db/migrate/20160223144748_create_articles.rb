class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|

      t.string :entry_id, :null => false
      t.string :title
      t.integer :points
      t.integer :comments 
      t.text :image_url 
      t.references :category

      t.timestamps
    end

    add_index :articles, :category_id
    add_index :articles, :entry_id, unique: true
  end
end
