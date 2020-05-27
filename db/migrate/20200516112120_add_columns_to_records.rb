class AddColumnsToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :summinutes, :integer,default: 0
    add_column :records, :memo, :text
  end
end
