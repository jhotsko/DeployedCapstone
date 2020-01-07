class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.string :workoutType
      t.date :workoutdate
      t.integer :repititions
      t.integer :distance
      t.references :cadet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
