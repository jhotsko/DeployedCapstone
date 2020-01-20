class AddTagToWarriorknowledges < ActiveRecord::Migration[6.0]
  def change
    add_column :warriorknowledges, :tag, :string
  end
end
