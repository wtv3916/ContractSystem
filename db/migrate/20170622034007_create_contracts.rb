class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.string :title
      t.string :renter
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
