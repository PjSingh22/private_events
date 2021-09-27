class ChangeEventColumnBack < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :creator_id, :user_id
  end
end
