class CreateDiabetics < ActiveRecord::Migration
  def change
    create_table :diabetics do |t|
      t.integer :glucose_level
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
