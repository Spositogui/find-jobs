class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :skills_description
      t.decimal :salary, precision: 8, scale: 2
      t.references :experience_level, foreign_key: true
      t.references :hiring_type, foreign_key: true
      t.string :address
      t.integer :home_office, default: 0
      t.date :registration_end_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
