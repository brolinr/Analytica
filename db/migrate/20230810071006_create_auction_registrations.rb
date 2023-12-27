class CreateAuctionRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :auction_registrations, id: :uuid do |t|
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.references :auction, null: false, foreign_key: true, type: :uuid
      t.boolean :company_approved

      t.timestamps
    end
  end
end
