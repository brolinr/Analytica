class CreateAuctions < ActiveRecord::Migration[7.0]
  def change
    create_table :auctions, id: :uuid do |t|
      t.string :title
      t.text :notes
      t.string :location
      t.boolean :expired, default: false
      t.datetime :start
      t.datetime :deadline
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
