class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :description
      t.references :person_type, foreign_key: true

      t.timestamps
    end
  end
end
