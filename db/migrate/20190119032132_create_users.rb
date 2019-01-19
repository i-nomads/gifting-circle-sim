class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :round
      t.references :circle, foreign_key: true
      t.integer :level
      t.integer :balance, default: -5000
      t.boolean :insider, default: false

      t.timestamps
    end
  end
end
