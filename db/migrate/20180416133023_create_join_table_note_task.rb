class CreateJoinTableNoteTask < ActiveRecord::Migration[5.2]
  def change
    create_join_table :notes, :tasks do |t|
      t.index [:note_id, :task_id]
    end
  end
end
