class CreateCompanyOnboardings < ActiveRecord::Migration[7.0]
  def change
    create_table :company_onboardings, id: :uuid do |t|
      t.string :name, null: false
      t.string :email,              null: false, default: ""
      t.string :phone, null: false
      t.string :address, null: false
      t.text :about, null: false, default: ''
      t.string :location, null: false
      t.boolean :terms_and_conditions, null: false
      t.boolean :buyer, null: false, default: false
      t.boolean :seller, null: false, default: false
      t.integer :approval, null: false, default: 0
      t.timestamps
    end

    add_index :company_onboardings, :email,                unique: true
    add_index :company_onboardings, :phone,                unique: true
  end
end
