class AddDateToWarriorknowledges < ActiveRecord::Migration[6.0]
  def change
    add_column :warriorknowledges, :date_assigned, :date
    add_column :warriorknowledges, :name, :string
  end
end
