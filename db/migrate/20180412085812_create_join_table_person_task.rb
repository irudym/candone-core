class CreateJoinTablePersonTask < ActiveRecord::Migration[5.2]
  def change
    create_join_table :persons, :tasks do |t|
      t.index [:person_id, :task_id]
    end
  end
end
