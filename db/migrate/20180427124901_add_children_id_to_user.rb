class AddChildrenIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :children_id, :integer
  end
end
