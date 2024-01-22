class CreateCompanyOnboardings < ActiveRecord::Migration[7.0]
  def change
    create_table :company_onboardings, id: :uuid do |t|
      t.boolean :terms_and_conditions, null: false, default: false
      t.boolean :buyer,                null: false, default: false
      t.boolean :seller,               null: false, default: false
      t.integer :approval,               null: false, default: 0
      t.text :reason_for_disapproval,                     null: false, default: ''
      t.string :name,                  null: false, default: ""
      t.string :email,                 null: false, default: ""
      t.string :location
      t.string :phone
      t.string :address
      t.string :approval_token
      t.timestamps
    end

    add_index :company_onboardings, :email,                unique: true
    add_index :company_onboardings, :phone,                unique: true
  end
end
