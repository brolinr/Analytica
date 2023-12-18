class CreateWatchedLots < ActiveRecord::Migration[7.0]
  def change
    create_table :watched_lots, id: :uuid do |t|
      t.references :lot, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
