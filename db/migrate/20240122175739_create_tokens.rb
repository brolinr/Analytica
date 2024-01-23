class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens, id: :uuid do |t|
      t.datetime :expired_at
      t.integer :status, default: 0
      t.integer :purpose
      t.string :secret
      t.references :generator, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
