class RemoveNumCorrectFromWarriorknowledges < ActiveRecord::Migration[6.0]
  def change
    remove_column :warriorknowledges, :num_correct
  end
end
