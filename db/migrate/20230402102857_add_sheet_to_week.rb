class AddSheetToWeek < ActiveRecord::Migration[7.0]
  def change
    add_column :weeks, :sheet, :string
  end
end
