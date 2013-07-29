class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :gender
      t.string :age
      t.references :occupation
      t.integer :zip
      t.timestamps
    end
  end
end
