class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :candidate, foreign_key: true
      t.references :job, foreign_key: true
      t.text :candidate_description

      t.timestamps
    end
  end
end
