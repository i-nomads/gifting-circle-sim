class CreateCircles < ActiveRecord::Migration[5.1]
  def change
    create_table :circles do |t|
      t.string :name
      t.integer :round

      t.timestamps
    end
  end
end
