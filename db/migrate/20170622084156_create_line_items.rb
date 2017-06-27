class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :unit_price
      t.integer :units
      t.decimal :total
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
