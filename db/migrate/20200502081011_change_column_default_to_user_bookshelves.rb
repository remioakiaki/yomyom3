class ChangeColumnDefaultToUserBookshelves < ActiveRecord::Migration[5.2]
  def up
    change_column :user_bookshelves, :status_id, :bigint, :default => 1
  end
end
