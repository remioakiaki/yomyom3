class AddColumnToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :page_amount, :integer,default: 0
    add_column :records, :minutes, :integer,default: 0
  end
end
