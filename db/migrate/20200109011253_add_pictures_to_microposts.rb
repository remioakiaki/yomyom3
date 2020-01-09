class AddPicturesToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :pictures, :json
  end
end
