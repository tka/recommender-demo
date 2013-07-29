class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :categories_movies, :id =>false do |t|
      t.integer :category_id
      t.integer :movie_id
    end
    add_index :categories_movies, :category_id
    add_index :categories_movies, :movie_id
  end
end
