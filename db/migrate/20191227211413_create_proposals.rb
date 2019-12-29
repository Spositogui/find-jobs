class CreateProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :proposals do |t|
      t.string :company_name
      t.date :start_date
      t.decimal :salary
      t.text :benefits
      t.string :role
      t.text :responsabilities
      t.references :hiring_type, foreign_key: true
      t.text :others
      t.references :subscription, foreign_key: true

      t.timestamps
    end
  end
end
