class AddReferenceToBookshelves < ActiveRecord::Migration[5.2]
  def change
    change_column :bookshelves,:status_id,  :bigint, :default => 1
  end
end
