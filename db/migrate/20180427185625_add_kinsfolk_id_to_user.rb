class AddKinsfolkIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :kinsfolk_id, :integer
  end
end
