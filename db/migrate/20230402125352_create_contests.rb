class CreateContests < ActiveRecord::Migration[7.0]
  def change
    create_table :contests do |t|
      t.string :name
      t.string :link
      t.datetime :start_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
