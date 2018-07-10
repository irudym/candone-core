class CreateJoinTableProjectNote < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :notes do |t|
      t.index [:project_id, :note_id]
    end
  end
end
