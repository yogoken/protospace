class AddWorksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :works, :text
  end
end
