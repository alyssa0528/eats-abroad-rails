class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :chef_id
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
