class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :due_date
      t.decimal :total
      t.references :renting_phase, foreign_key: true

      t.timestamps
    end
  end
end
