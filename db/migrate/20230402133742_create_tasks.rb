class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :todo
      t.datetime :deadline
      t.references :coach, null: false, foreign_key: { to_table: :users }
      t.references :trainee, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
