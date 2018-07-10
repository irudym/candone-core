class CreateJoinTableProjectPeople < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :people do |t|
      t.index [:note_id, :person_id]
    end
  end
end
