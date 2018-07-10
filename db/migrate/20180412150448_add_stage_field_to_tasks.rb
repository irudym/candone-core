class AddStageFieldToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :stage, :integer, default: 0
  end
end
