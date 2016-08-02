class AddRoleToPrototypeImages < ActiveRecord::Migration
  def change
    add_column :prototype_images, :role, :integer, default: 0, null: false, limit: 1
  end
end
