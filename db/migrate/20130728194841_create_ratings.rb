class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user
      t.references :movie
      t.float :rate
      t.timestamps
    end

    add_index :ratings, :user_id
    add_index :ratings, :movie_id
  end
end
