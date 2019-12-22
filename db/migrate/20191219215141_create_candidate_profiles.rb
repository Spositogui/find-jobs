class CreateCandidateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :candidate_profiles do |t|
      t.string :name
      t.string :nickname
      t.date :date_of_birth
      t.references :candidate_formation, foreign_key: true
      t.text :description
      t.text :experience

      t.timestamps
    end
  end
end
