class CreateWeeks < ActiveRecord::Migration[7.0]
  def change
    create_table :weeks do |t|
      t.string :title
      t.text :materials
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
