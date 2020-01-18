class AddMarkupToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :markup, :integer, default: 0
  end
end
