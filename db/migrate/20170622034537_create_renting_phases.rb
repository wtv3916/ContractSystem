class CreateRentingPhases < ActiveRecord::Migration[5.1]
  def change
    create_table :renting_phases do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :price
      t.integer :cycles
      t.references :contract, foreign_key: true

      t.timestamps
    end
  end
end
