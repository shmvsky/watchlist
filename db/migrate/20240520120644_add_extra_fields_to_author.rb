class AddExtraFieldsToAuthor < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :height, :float
    add_column :authors, :birth_place, :string
  end
end
