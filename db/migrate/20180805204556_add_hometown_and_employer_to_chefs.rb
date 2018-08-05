class AddHometownAndEmployerToChefs < ActiveRecord::Migration[5.2]
  def change
    add_column :chefs, :hometown, :string
    add_column :chefs, :employer, :string
  end
end
