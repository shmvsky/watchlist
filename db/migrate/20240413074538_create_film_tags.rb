class CreateFilmTags < ActiveRecord::Migration[7.1]
  def change
    create_table :film_tags do |t|
      t.references :film, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end
  end
end
