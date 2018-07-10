class CreateJoinTableNotePerson < ActiveRecord::Migration[5.2]
  def change
    create_join_table :notes, :persons do |t|
      t.index [:person_id, :note_id]
    end
  end
end
