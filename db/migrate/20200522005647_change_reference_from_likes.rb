class ChangeReferenceFromLikes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :likes, :book, index: true
    # remove_foreign_key :likes, :book
    remove_reference :likes, :status, index: true
    # remove_foreign_key :likes, :status
    add_reference :likes, :micropost, foreign_key: true
  end
end
