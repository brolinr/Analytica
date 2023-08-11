class CreateAuctions < ActiveRecord::Migration[7.0]
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :notes
      t.string :location
      t.boolean :expired
      t.datetime :start
      t.datetime :deadline
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
