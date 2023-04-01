class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :codeforces_handle
      t.string :role
      t.string :level
      t.string :title

      t.timestamps
    end
  end
end
