class RenameTableNotesPersonsToNotesPeople < ActiveRecord::Migration[5.2]
  def change
    rename_table :notes_persons, :notes_people
  end
end
