class CreatePrototypes < ActiveRecord::Migration
  def change
    create_table :prototypes do |t|
      t.references :user, index: true, foreign_key: true
      t.string     :title
      t.string     :catch_copy
      t.text       :concept
      t.timestamps null: false
    end
  end
end
