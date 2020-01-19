class RemoveCadetIdFromWarriorknowledges < ActiveRecord::Migration[6.0]
  def change
    remove_column :warriorknowledges, :cadet_id
  end
end
