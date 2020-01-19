class CreateWarriorknowledges < ActiveRecord::Migration[6.0]
  def change
    create_table :warriorknowledges do |t|
      t.integer :num_questions
      t.integer :num_correct
      t.references :cadet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
