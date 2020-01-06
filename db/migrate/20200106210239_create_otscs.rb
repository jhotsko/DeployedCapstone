class CreateOtscs < ActiveRecord::Migration[6.0]
  def change
    create_table :otscs do |t|
      t.date :date
      t.string :description
      t.references :cadet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
