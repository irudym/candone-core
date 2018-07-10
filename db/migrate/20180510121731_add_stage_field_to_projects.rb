class AddStageFieldToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :stage, :integer, default: 1
  end
end
