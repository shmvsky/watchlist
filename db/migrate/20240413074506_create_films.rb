class CreateFilms < ActiveRecord::Migration[7.1]
  def change
    create_table :films do |t|
      t.string :title, null: false
      t.index :title, unique: true
      t.text :note
      t.integer :rate, null: false
      t.integer :status, default: 0
      t.references :author, null: false, foreign_key: true
    end
  end
end
