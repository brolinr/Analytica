class CreateWatchedLots < ActiveRecord::Migration[7.0]
  def change
    create_table :watched_lots do |t|
      t.references :lot, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
