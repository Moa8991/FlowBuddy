class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.references :routine, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :estimated_min

      t.timestamps
    end
  end
end
