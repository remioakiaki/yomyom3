class ChangeColumnToLikes < ActiveRecord::Migration[5.2]
  def change
    add_column :likes,:status_id,  :bigint, :default => 1
  end
end
