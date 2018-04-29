class CreateParents < ActiveRecord::Migration[5.1]
  def change
    create_table :parents do |t|
      t.integer :user_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
