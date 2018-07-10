class CreateJoinTableProjectTask < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :tasks do |t|
      t.index [:project_id, :task_id]
    end
  end
end
