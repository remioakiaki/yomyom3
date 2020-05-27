class ChangeDefaultColumn < ActiveRecord::Migration[5.2]
  def change
    change_column_default :records, :hours, nil
    remove_column :records, :hhmm, :time
  end
end
