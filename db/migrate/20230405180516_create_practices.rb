class CreatePractices < ActiveRecord::Migration[7.0]
  def change
    create_table :practices do |t|
      t.references :trainee, null: false, foreign_key: { to_table: :users }
      t.references :contest, null: false, foreign_key: { to_table: :contests }
      t.integer :problems

      t.timestamps
    end
  end
end
