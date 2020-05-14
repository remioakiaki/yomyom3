class RemoveUserIdFromRecords < ActiveRecord::Migration[5.2]
  def change
    remove_reference :records, :user, index: true
    remove_foreign_key :records, :user
     add_reference :records, :bookshelf, foreign_key: true
  end
end
