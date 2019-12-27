class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :candidate, foreign_key: true
      t.references :head_hunter, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
