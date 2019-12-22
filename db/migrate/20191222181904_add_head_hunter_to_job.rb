class AddHeadHunterToJob < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :head_hunter, foreign_key: true
  end
end
