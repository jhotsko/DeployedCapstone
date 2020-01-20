class CreateGrades < ActiveRecord::Migration[6.0]
  def change
    create_table :grades do |t|
      t.integer :num_correct
      t.references :cadet, null: false, foreign_key: true
      t.references :warriorknowledge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
