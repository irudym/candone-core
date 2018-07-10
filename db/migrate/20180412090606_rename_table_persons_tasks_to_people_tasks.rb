class RenameTablePersonsTasksToPeopleTasks < ActiveRecord::Migration[5.2]
  def change
    rename_table :persons_tasks, :people_tasks
  end
end
