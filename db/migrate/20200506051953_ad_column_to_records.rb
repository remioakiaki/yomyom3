class AdColumnToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :hours, :integer,default: 0
  end
end
