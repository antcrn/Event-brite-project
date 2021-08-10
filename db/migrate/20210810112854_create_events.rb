class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.integer :price
      t.datetime :start_date
      t.integer :duration

      t.references :administrator, index: true
      t.timestamps
    end
  end
end
