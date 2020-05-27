class ChangeDataIntToFloatToRecords < ActiveRecord::Migration[5.2]
  def up
    change_column :records, :minutes, :integer
    change_column :records, :hours, :integer
    change_column :records, :summinutes, :float
  end

  def def down 
    change_column :records, :minutes, :integer
    change_column :records, :hours, :integer
    change_column :records, :summinutes, :integer
  end
end
