class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.string :title
      t.integer :quantity
      t.integer :asking_price
      t.string :location
      t.string :condition
      t.references :company, null: false, foreign_key: true
      t.references :auction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
