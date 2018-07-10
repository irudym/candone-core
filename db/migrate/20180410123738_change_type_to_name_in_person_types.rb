class ChangeTypeToNameInPersonTypes < ActiveRecord::Migration[5.2]
  def change
    remove_column :person_types, :type
    add_column :person_types, :name, :string
  end
end
