class RemoveExtraFieldsFromAuthor < ActiveRecord::Migration[7.1]
  def change
    remove_column :authors, :height, :float
    remove_column :authors, :birth_place, :string
  end
end
