class CreateKeyResults < ActiveRecord::Migration[5.2]
  def change
    create_table :key_results do |t|
      t.string :content
      t.integer :numerical_goal
      t.references :ambition, foreign_key: true

      t.timestamps
    end
  end
end
