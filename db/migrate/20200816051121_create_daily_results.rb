class CreateDailyResults < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_results do |t|
      t.integer :result
      t.date :result_date
      t.references :key_result, foreign_key: true

      t.timestamps
    end
  end
end
