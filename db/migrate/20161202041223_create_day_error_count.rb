class CreateDayErrorCount < ActiveRecord::Migration[5.0]
  def change
    create_table :day_error_counts do |t|
      t.date :day, null: false
      t.integer :error_count, null: false

      t.timestamps
    end
  end
end
