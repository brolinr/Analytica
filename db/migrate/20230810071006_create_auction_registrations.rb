class CreateAuctionRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :auction_registrations do |t|
      t.references :company, null: false, foreign_key: true
      t.references :auction, null: false, foreign_key: true
      t.boolean :company_approved

      t.timestamps
    end
  end
end
