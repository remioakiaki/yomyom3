class AddColumnsToBooksAndMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :likes_count, :integer, null: false,default:0
    add_column :microposts, :comments_count, :integer, null: false,default:0
    add_column :books, :avg_rate, :float, null: false,default:0.0
  end
end
